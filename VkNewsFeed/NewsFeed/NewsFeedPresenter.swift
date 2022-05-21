//
//  NewsFeedPresenter.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 13.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    
    weak var viewController: NewsFeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        return dateFormatter
    }()
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
        case .presentNewsFeed(feed: let feed, let revealedPostIds):
            
            let cells = feed.items.map { feedItem in
                cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, revealedPostIds: revealedPostIds)
            }
            
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("news feed cells count", comment: ""), cells.count)
            
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            
            viewController?.displayData(viewModel: .displayNewsFeed(feedViewMode: feedViewModel))
             
        case .presentUserInfo(let user):
            let userViewModel = UserViewModel(photoUrl: user?.photo100)
            viewController?.displayData(viewModel: .displayUser(userViewModel: userViewModel))
       
        case .presentFooterLoader:
            viewController?.displayData(viewModel: .displayFooterLoader)
        }
        
    }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], revealedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)!
        let photoAttachments = photoAttachments(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
//        let isFullSized = revealedPostIds.contains { postId -> Bool in
//            return postId == feedItem.postId
//        }
        
        let isFullSized = revealedPostIds.contains(feedItem.postId)
         
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSized: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(
            postId: feedItem.postId,
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: postText,
            likes: formattedCounter(feedItem.likes?.count),
            comments: formattedCounter(feedItem.comments?.count),
            shares: formattedCounter(feedItem.reposts?.count),
            views: formattedCounter(feedItem.views?.count),
            photoAttachments: photoAttachments,
            sizes: sizes
        )
    }
    
    private func formattedCounter(_ counter: Int?) -> String? {
        guard let counter = counter, counter > 0 else { return nil }
        
        var stringCounter = String(counter)
        
        if 4...6 ~= stringCounter.count {
            stringCounter = String(stringCounter.dropLast(3)) + "K"
        } else if stringCounter.count > 6 {
            stringCounter = String(stringCounter.dropLast(6)) + "M"
        }
        
        return stringCounter
    }
    
    private func profile(sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable?  {
        
        let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profileRepresentable = profilesOrGroups.first { myProfileRepresentable -> Bool in
            myProfileRepresentable.id == normalSourceId
        }
        
        return profileRepresentable
    }
    
    private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ attachment in
            attachment.photo
        }), let firstPhoto = photos.first else { return nil }
        
        return FeedViewModel.FeedCellPhotoAttachment(
            photoUrlString: firstPhoto.srcBig,
            width: firstPhoto.width,
            height: firstPhoto.height
        )
    }
    
    private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
        
        guard let attachments = feedItem.attachments else { return []}
        
        return attachments.compactMap { attachment -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else { return nil}
            return FeedViewModel.FeedCellPhotoAttachment(photoUrlString: photo.srcBig,
                                                  width: photo.width,
                                                  height: photo.height)
        }
    }
    
}
