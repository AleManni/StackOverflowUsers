//
//  UsersDatabase.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 17/10/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import Foundation
import SharedComponents

protocol UsersDatabaseProtocol {
  func saveUsers(_ users: UsersListNetworkModel) throws
  func retrieveUsers() -> OperationResult<UsersListNetworkModel>
}


final class UsersDatabase: UsersDatabaseProtocol {
  
  private lazy var encoder = PropertyListEncoder()
  private lazy var decoder = PropertyListDecoder()
  
  
  private let key = "user"
  
  func filePath(key: String) throws -> URL {
    do {
      if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        return url.appendingPathComponent(key)
      } else { throw APIErrors.invalidRequest
      }
    }
  }
  
  func saveUsers(_ users: UsersListNetworkModel) throws {
    do {
      let data = try encoder.encode(users)
      try data.write(to: filePath(key: "usersList"))
    }
  }
  
    func retrieveUsers() -> OperationResult<UsersListNetworkModel> {
      do  {
        let url = try filePath(key: "usersList")
        let data = try Data(contentsOf: url)
        let list  = try decoder.decode(UsersListNetworkModel.self, from:  data)
        return .success(list)
      } catch let error {
        return .failure(error)
      }
    }
}
