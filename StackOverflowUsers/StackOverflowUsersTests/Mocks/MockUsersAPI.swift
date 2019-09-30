//
//  MockUsersAPI.swift
//  StackOverflowUsersTests
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

@testable import StackOverflowUsers
import SharedComponents

final class MockUsersAPI: UsersAPIProtocol {
  
  var success: Bool = true
  
  func getUsers(completion: @escaping (OperationResult<UsersListNetworkModel>) -> Void) {
    switch success {
    case true:
      do {
        let json = try TestUtilities.loadJSONFile("users_list", inBundle: Bundle(for: MockUsersAPI.self))
        let userList = try JSONDecoder().decode(UsersListNetworkModel.self, from: json)
        completion(.success(userList))
      } catch let error {
        completion(.failure(error))
      }
    default:
      completion(.failure(APIErrors.invalidRequest))
    }
  }
}
