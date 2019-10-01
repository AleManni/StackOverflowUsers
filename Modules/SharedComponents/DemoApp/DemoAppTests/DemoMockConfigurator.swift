//
//  DemoMockConfigurator.swift
//  DemoAppTests
//
//  Created by Alessandro Manni on 19/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import Foundation
@testable import SharedComponents

class MockNetworkConfigurator: NetworkConfigurator {

  var headers: [String: Any]?

  var configurationForCurrentEnvironment: URLSessionConfiguration {
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = headers
    return config
  }
}

class MockNetworkClient: NetworkClient {

  var mockJson: String?

  var expectedResult: NetworkResult = .success("Test string")

  var configuration: URLSessionConfiguration

  init(configuration: URLSessionConfiguration) {
    self.configuration = configuration
  }

  func handleRequest(_ request: URLRequest, completion: @escaping (NetworkResult) -> Void) {
    completion(expectedResult)
  }

}

class MockImageNetworkClient: NetworkClient {

  lazy var expectedResult: NetworkResult = {
    let image = UIImage(named: "ic_placeholder")
    let data = image!.jpegData(compressionQuality: 1)
    return .success(data)
  }()

  var configuration: URLSessionConfiguration

  init(configuration: URLSessionConfiguration) {
    self.configuration = configuration
  }

  func handleRequest(_ request: URLRequest, completion: @escaping (NetworkResult) -> Void) {
    completion(expectedResult)
  }
}

