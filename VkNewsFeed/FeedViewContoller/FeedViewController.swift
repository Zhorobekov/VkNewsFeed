//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 29.04.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService: NetworkingProtocol = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        let params = ["filters":  "post, photo"]
        networkService.request(path: API.newsFeed, params: params) { data, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let data = data else { return }
            let response = try? decoder.decode(FeedResponseWrapped.self, from: data)
        }
    }


}
