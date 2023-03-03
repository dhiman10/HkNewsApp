//
//  ViewController.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import UIKit
import Combine

class StoryListViewController: UIViewController, StoryListViewViewDelegate {

    private var cancellable : AnyCancellable?
    
    private let storyListView = StoryListView()

    private let viewModel = StoryListViewModel()

    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        storyListView.delegate = self
        view.addSubview(storyListView)
        addConstraints()
        setUpObervers()
        viewModel.fetchTopStories()

        //fetchTopStories()
    }
    
    //MARK: - private
    private func setUpObervers() {
        
        self.cancellable = viewModel.$stories
            .receive(on: RunLoop.main)
            .sink(receiveValue: { contacts in
                self.storyListView.configure(with: self.viewModel)
            })
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            storyListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            storyListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            storyListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            storyListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func storyView(_ locationView: StoryListView, didSelect storyId: Int) {
        
        let vc = StoryDetailViewController(storyId:storyId)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

