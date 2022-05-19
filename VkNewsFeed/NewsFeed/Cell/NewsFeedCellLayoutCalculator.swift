//
//  NewsFeedCellLayoutCalculator.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 16.05.2022.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var moreTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeight: CGFloat
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes {
        
        var showMoreTextButton: Bool = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //MARK: Work with postLabelFrame
        
        var postLabelFrame = CGRect(
            origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
            size: CGSize.zero
        )
        
        if let postText = postText, !postText.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = postText.height(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSized && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //MARK: Work with MoreTextButtonFrame
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        
        //MARK: Work with AttachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(
            origin: CGPoint(x: 0, y: attachmentTop),
            size: CGSize.zero
        )
        
        //        if let photoAttachments = photoAttachments {
        //
        //
        //            let photoHeight: Float = Float(photoAttachment.height)
        //            let photoWidth: Float = Float(photoAttachment.width)
        //
        //            let ratio = CGFloat(photoHeight / photoWidth)
        //
        //            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
        //        }
        
        if let photoAttachment = photoAttachments.first {
            let photoHeight: Float = Float(photoAttachment.height)
            let photoWidth: Float = Float(photoAttachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            }
        }
        
        //MARK: Work with bottomViewFrame
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        
        let bottomViewFrame = CGRect(
            origin: CGPoint(x: 0, y: bottomViewTop),
            size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        
        //MARK: Work with totalHeight
        
        let totalHeight = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeight: totalHeight)
    }
}
