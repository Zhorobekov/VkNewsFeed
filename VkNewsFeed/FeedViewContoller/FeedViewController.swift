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
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json)
        }
    }


}
