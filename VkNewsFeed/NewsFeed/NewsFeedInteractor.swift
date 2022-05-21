//
//  NewsFeedInteractor.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 13.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
            
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (revealedPostIds, feed) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .revealPostIds(let postId):
            service?.revealedPostIds(forPostId: postId, completion: { [weak self] revealedPostIds, feed in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] user in
                self?.presenter?.presentData(response: .presentUserInfo(user: user))
            })
        case .getNextBatch:
            self.presenter?.presentData(response: .presentFooterLoader)
            service?.getNextBatch(completion: { revealedPostIds, feed in
                self.presenter?.presentData(response: .presentNewsFeed(feed: feed, revealedPostIds: revealedPostIds))
            })
        }
    }
}
