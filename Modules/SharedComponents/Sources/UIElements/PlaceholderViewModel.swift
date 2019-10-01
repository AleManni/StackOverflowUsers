//
//  PlaceholderViewModel.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 30/09/2019.
//

import Foundation

public struct PlaceholderViewModel {
  let primaryText: String
  let secondaryText: String
  
  public init(primaryText: String, secondaryText: String) {
    self.primaryText = primaryText
    self.secondaryText = secondaryText
  }
}
