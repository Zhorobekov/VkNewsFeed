//
//  TitleView .swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 21.05.2022.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrl: String? { get  }
}


class TitleView: UIView {
    
    private var myAvatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var searchTextField = InsetableTextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(myAvatarView)
        addSubview(searchTextField)
        
        makeConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel) {
        myAvatarView.set(imageUrl: userViewModel.photoUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        
        //myAvatarView constrains
        myAvatarView.anchor(top: topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: trailingAnchor,
                            padding: UIEdgeInsets(top: 4, left: 999, bottom: 999, right: 4))
        myAvatarView.heightAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
        
        //searchTextField constrains
        
        searchTextField.anchor(top: topAnchor,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: myAvatarView.leadingAnchor,
                               padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
                            
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    
}
