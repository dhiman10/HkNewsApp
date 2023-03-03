//
//  File.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import Foundation
import Combine

class StoryListViewModel : ObservableObject {

    @Published var stories = [storyViewModel]()
    private var cancellable : AnyCancellable?
    
    init() {
    }
    
    public func fetchTopStories() {
        
        self.cancellable = WebService().getAllTopstories().map { stories in
            stories.map{storyViewModel(story: $0)}
        }.sink(receiveCompletion: { _ in }, receiveValue: { storyViewModels in
            self.stories = storyViewModels
            //print(self.stories)
        })
    }


}


struct storyViewModel {
    
    let story : Story

    var id: Int {
        return self.story.id
    }

    var title: String {
        return self.story.title
    }

    var url: String {
        return self.story.url
    }
    
   // let id : Int
}
