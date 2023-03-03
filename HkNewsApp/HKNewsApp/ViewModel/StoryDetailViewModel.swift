//
//  StoryDetailViewModel.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import Foundation
import Combine

class StoryDetailViewModel: ObservableObject {
    
    private var cancellable : AnyCancellable?
    @Published public var story = Story.placeholder()
    
    public func fetchStoryDetails(storyId: Int) {
        
         print("about to make a network request")
        self.cancellable = WebService().getStoryById(storyId: storyId)
                  .catch { _ in Just(Story.placeholder()) }
                  .sink(receiveCompletion: { _ in }, receiveValue: { story in
                      self.story = story
                      //print(story)
        })
    }
    
}
extension StoryDetailViewModel {
    
    var title : String {
        return self.story.title
    }
    
    var url : String {
        return self.story.url
    }
    
}
