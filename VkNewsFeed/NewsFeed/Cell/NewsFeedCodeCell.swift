//
//  NewsFeedCodeCell.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 16.05.2022.
//

import UIKit

protocol NewsFeedCodeCellDelegate: AnyObject {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    // First layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    
    // Second layer
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        return textView
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0.3098039216, blue: 0.3294117647, alpha: 1)
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Third layer on topView
    
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return nameLabel
    }()
    
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        return dateLabel
    }()
    
    // Third layer on bottomView
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Fourth layer on bottomViewViews
    
    let likesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let sharesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        imageView.tintColor = .lightGray
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        label.text = "453K"
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constants.topViewHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonPressed), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnTopView()
        overlayThirdLayerOnBottomView()
        overlayFourthLayerOnBottomViewViews()
        
        helpInFourthLayer(view: likesView, imageView: likesImageView, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentsImageView, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: sharesImageView, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewsImageView, label: viewsLabel)
    }
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    @objc func moreTextButtonPressed() {
        delegate?.revealPost(for: self)
    }
    
    private func overlayFourthLayerOnBottomViewViews() {
        likesView.addSubview(likesImageView)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImageView)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImageView)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewsImageView)
        viewsView.addSubview(viewsLabel)
        
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        
        //imageView constraints
        
        NSLayoutConstraint.activate([
            //imageView constraints
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewIconSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewIconSize),
            
            //label constraints
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
    }
    
    private func overlayThirdLayerOnBottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
        //likesView constraints
        likesView.anchor(top: bottomView.topAnchor,
                         leading: bottomView.leadingAnchor,
                         bottom: nil,
                         trailing: nil,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //commentsView constraints
        commentsView.anchor(top: bottomView.topAnchor,
                            leading: likesView.trailingAnchor,
                            bottom: nil,
                            trailing: nil,
                            size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //sharesView constraints
        sharesView.anchor(top: bottomView.topAnchor,
                          leading: commentsView.trailingAnchor,
                          bottom: nil,
                          trailing: nil,
                          size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
        
        //viewsView constraints
        viewsView.anchor(top: bottomView.topAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: bottomView.trailingAnchor,
                         size: CGSize(width: Constants.bottomViewViewWidth, height: Constants.bottomViewViewHeight))
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
        
        //iconImageView constraints
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            iconImageView.topAnchor.constraint(equalTo: topView.topAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight)
        ])
        
        
        //nameLabel constraints
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2),
            nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight/2 - 2)
        ])
        
        //dateLabel constraints
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8),
            dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2),
            dateLabel.heightAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(bottomView)
        
        //topView constraints
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
            topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
            topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight)
        ])
    }
    
    private func overlayFirstLayer() {
        contentView.addSubview(cardView)
        
        //carView constraints
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    func set(viewModel: FeedCellViewModel) {
        
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        postLabel.frame = viewModel.sizes.postLabelFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageUrl: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
