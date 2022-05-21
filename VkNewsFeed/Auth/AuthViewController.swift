//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 28.04.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    @IBOutlet private weak var enterButton: UIButton!
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        enterButton.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        enterButton.layer.borderWidth = 2
        enterButton.layer.cornerRadius = 10
        enterButton.layer
        
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

