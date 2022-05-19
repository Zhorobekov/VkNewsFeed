//
//  GalleryCollectionView.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 19.05.2022.
//

import UIKit

class GalleryCollectionView: UICollectionView {
    
    var photos: [FeedCellPhotoAttachmentViewModel] = []
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: "GalleryCollectionViewCell")
        
        delegate = self
        dataSource = self
        
        backgroundColor = .cyan
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GalleryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "GalleryCollectionViewCell", for: indexPath) as! GalleryCollectionViewCell
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
}


