//
//  ShortListView.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import UIKit
import Combine

protocol StoryListViewViewDelegate : AnyObject {
    func storyView(_ locationView : StoryListView, didSelect storyId : Int)
}


final class StoryListView: UIView {
    
    weak var delegate: StoryListViewViewDelegate?

      private var viewModel : StoryListViewModel?{
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1.0
            }
        }
    }
    
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        //table.alpha = 0
        //table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier:"cell")
        return table
    }()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(tableView,spinner)
        spinner.startAnimating()
        addConstraints()
        confiqureTable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func confiqureTable() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
    
    //MARK: - public

    public func configure(with viewModel : StoryListViewModel) {
        self.viewModel = viewModel
    }
}


extension StoryListView : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cellIndex = viewModel?.stories[indexPath.row] else {
                    fatalError("Cell is no data")
                }
        
        delegate?.storyView(self, didSelect: cellIndex.story.id)
    }
}


extension StoryListView : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.stories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let cellViewModel = viewModel?.stories[indexPath.row] else {
                    fatalError("Cell is no data")
                }
        

        cell.textLabel?.text = "\(cellViewModel.title)"
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    
}
