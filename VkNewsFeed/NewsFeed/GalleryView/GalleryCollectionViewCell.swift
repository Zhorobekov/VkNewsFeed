//
//  GalleryCollectionViewCell.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 19.05.2022.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .green
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(myImageView)
        
        backgroundColor = .blue
        
//        myImageView constraints
        myImageView.fillSuperview()
        
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageUrl: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
