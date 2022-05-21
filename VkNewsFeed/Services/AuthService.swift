//
//  AuthService.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 28.04.2022.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSignIn()
    func authServiceSignInFailed()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "8152459"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("vkSdk.initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken().accessToken
    }
    
    var userId: String? {
        return VKSdk.accessToken().userId 
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {            
            delegate?.authServiceSignIn()
        }
        print(#function)
    }
    
    func vkSdkUserAuthorizationFailed() {
        delegate?.authServiceSignInFailed()
        print(#function)
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(viewController: controller)
        print(#function)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
    
    func wakeUpSession() {
        let scope = ["wall","friends"]
        VKSdk.wakeUpSession(scope) { [delegate] state, error in
            switch state {
            case .initialized:
                VKSdk.authorize(scope)
            case .authorized:
                delegate?.authServiceSignIn()
            default:
                delegate?.authServiceSignInFailed()
            }
        }
    }
}
