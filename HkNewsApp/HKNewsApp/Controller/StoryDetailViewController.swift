//
//  StoryDetailViewController.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import UIKit
import Combine
import CoreData

final class StoryDetailViewController: UIViewController {
    
    private var cancellable : AnyCancellable?
    
    private let storyDetailView = StoryDetailView()

    private let viewModel = StoryDetailViewModel()
    
    private var storyId : Int
    
    //MARK: - Init

    init(storyId: Int){
        self.storyId = storyId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        view.backgroundColor = .systemBackground
       // navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubviews(storyDetailView)
        addConstraints()
        setUpObervers()
        self.viewModel.fetchStoryDetails(storyId: self.storyId)

    }
    
    //MARK: - private
    private func setUpObervers() {
        
        self.cancellable = viewModel.$story
            .receive(on: RunLoop.main)
            .sink(receiveValue: { contacts in
                self.storyDetailView.configure(with: self.viewModel)
            })
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            storyDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            storyDetailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            storyDetailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            storyDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    
    }



}
