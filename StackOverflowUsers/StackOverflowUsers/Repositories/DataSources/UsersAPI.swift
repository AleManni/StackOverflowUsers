//
//  UsersAPI.swift
//  StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import SharedComponents

protocol UsersAPIProtocol {
  
  func getUsers(completion: @escaping (OperationResult<UsersListNetworkModel>) -> Void)
  
}


final class UsersAPI: UsersAPIProtocol, API {
  
  typealias NetworkModel = UsersListNetworkModel
  
  enum EndPoints: String {
    case users
  }
  
  var networkService: NetworkService?
  
  init(_ networkService: NetworkService) {
    self.networkService = networkService
  }
  
  convenience init() {
    self.init(NetworkService.safeSession)
  }
  
  func getUsers(completion: @escaping (OperationResult<UsersListNetworkModel>) -> Void) {
    
    let request = APIRequestBuilder(base: "http://api.stackexchange.com",
                                    endpoint: EndPoints.users.rawValue,
                                    parameters: [
                                      (.custom("pagesize"), ["20"]),
                                      (.custom("order"), ["desc"]),
                                      (.custom("sort"), ["reputation"]),
                                      (.custom("site"), ["stackoverflow"])],
                                    apiVersion: .custom("2.2"))
    
    getObject(request: request, completion: { result in
      switch result {
      case .success(let models):
        completion(.success(models))
      case .failure(let error):
        completion(.failure(APIErrors.networkError(error)))
      }
    })
  }
}

