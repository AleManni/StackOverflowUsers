//
//  UserCellViewModel.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 30/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import Foundation

struct UserCellViewModel {
  let mainImageURL: String
  let icon: String
  let primaryLabelText: String
  let secondaryLabelText: String
  let primaryButtonTitle: String
  let secondayButtonTitle: String
  let isDisclosed: Bool
  let isDisabled: Bool
}

extension UserCellViewModel {
  
  init(with domainModel: User, isDisclosed: Bool = false) {
    self.mainImageURL = domainModel.imageURL
    self.icon = domainModel.isFollowed ? "❤️" : ""
    self.primaryLabelText = domainModel.name
    self.secondaryLabelText = String(domainModel.reputation)
    self.primaryButtonTitle = domainModel.isFollowed ? NSLocalizedString("Unfollow", comment: "") : NSLocalizedString("Follow", comment: "")
    self.secondayButtonTitle = NSLocalizedString("Block", comment: "")
    self.isDisclosed = isDisclosed
    self.isDisabled = domainModel.isBlocked
  }
}


