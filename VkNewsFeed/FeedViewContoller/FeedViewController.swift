//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 29.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService: NetworkingProtocol = NetworkService()
    private var fetcher: DataFetcher =  NetworkDataFetcher(networking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        fetcher.getFeed { feedResponse in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { feedItem in
                print(feedItem.date)
            }
        }
    }


}
