//
//  APIMockNetworkClient.swift
//  Pods-StackOverflowUsers
//
//  Created by Alessandro Manni on 29/09/2019.
//

import Foundation

class APIMockNetworkClient: NetworkClient {
  
  var mockJson: String?
  var bundle: Bundle?
  
  var configuration: URLSessionConfiguration
  
  init(configuration: URLSessionConfiguration) {
    self.configuration = configuration
  }
  
  func handleRequest(_ request: URLRequest, completion: @escaping (NetworkResult) -> Void) {
    guard let mockJson = mockJson,
      let bundle = bundle else {
        assertionFailure("missing parameters for this mock to work")
        return
    }
    do {
      let data = try TestUtilities.loadJSONFile(mockJson, inBundle: bundle)
      completion(.success(data))
    } catch let error {
      completion(.failure(error))
    }
  }
}
