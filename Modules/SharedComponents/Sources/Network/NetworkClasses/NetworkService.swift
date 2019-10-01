//
//  NetworkService.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 16/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
import UIKit

public final class NetworkService: AppService, ApplicationService, Network {

  private var networkClient: NetworkClient
  private let configurator: NetworkConfigurator

  public static let safeSession = NetworkService(networkClient: DefaultNetworkClient(),
                                          configurator: EphemeralNetworkConfigurator())

  public static let cachedSession = NetworkService(networkClient: DefaultNetworkClient(),
                                     configurator: CachingNetworkConfigurator())

  public required init(networkClient: NetworkClient, configurator: NetworkConfigurator) {
    self.networkClient = networkClient
    self.configurator = configurator
  }

  public func configureService() {
    networkClient.configuration = configurator.configurationForCurrentEnvironment
  }

  public func handleRequest(_ request: URLRequest, completion: @escaping (NetworkResult) -> Void) {

    // Point of injection for auth headers, app common headers etc.

    networkClient.handleRequest(request, completion: { result in
      DispatchQueue.main.async {
      completion(result)
      }
    })
  }
}
