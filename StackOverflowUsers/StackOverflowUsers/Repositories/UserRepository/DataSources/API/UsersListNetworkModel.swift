//
//  UserAPIModel.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import Foundation

struct UsersListNetworkModel: Codable {
  let users: [UserNetworkModel]

  enum CodingKeys: String, CodingKey {
    case users = "items"
  }
}

struct UserNetworkModel {
  let identifier: Int
  let name: String
  let reputation: Int
  let imageURL: String
}

extension UserNetworkModel: Codable {
  
  enum CodingKeys: String, CodingKey {
    case identifier = "account_id"
    case name = "display_name"
    case imageURL = "profile_image"
    case reputation
  }
  
}
