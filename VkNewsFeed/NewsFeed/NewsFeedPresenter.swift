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

    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        return dateFormatter
    }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
      switch response {
      case .presentNewsFeed(feed: let feed):
          
          let cells = feed.items.map { feedItem in
              cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
          }
          
          let feedViewModel = FeedViewModel.init(cells: cells)
          
          viewController?.displayData(viewModel: .displayNewsFeed(feedViewMode: feedViewModel))
      }
      
  }
    
    private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
       
        let profile = self.profile(sourceId: feedItem.sourceId, profiles: profiles, groups: groups)!
        let photoAttachment = photoAttachment(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        return FeedViewModel.Cell.init(
            iconUrlString: profile.photo,
            name: profile.name,
            date: dateTitle,
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shares: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0),
            photoAttachment: photoAttachment
        )
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
  
}
