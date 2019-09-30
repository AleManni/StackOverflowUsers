//
//  User.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import Foundation

struct User: Hashable {
  let identifier: Int
  let name: String
  let reputation: Int
  let imageURL: String
  let isFollowed: Bool
  let isBlocked: Bool
}

