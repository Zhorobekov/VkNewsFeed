//
//  ViewController.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 28.04.2022.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!

    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
        view.backgroundColor = .red
    }

    @IBAction func signInTapped(_ sender: UIButton) {
        authService.wakeUpSession()
    }
    
}

