//
//  UserResponse.swift
//  VkNewsFeed
//
//  Created by Эрмек Жоробеков on 21.05.2022.
//

import Foundation

struct UserResponseWrapped: Decodable {
    let response: [UserResponse]
}

struct UserResponse: Decodable {
    let photo100: String?
}
