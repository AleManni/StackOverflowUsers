//
//  APIInterface.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 17/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation

public protocol API: DataSource {
  associatedtype NetworkModel: Codable
  var networkService: NetworkService? { get set }
}

extension API {

  public func getObject(request: APIRequestBuilder, completion: @escaping ((OperationResult<NetworkModel>) -> Void)) {
    do {
        let request = try request.makeRequest()
      networkService?.handleRequest(request, completion: { networkCompletion in

        switch networkCompletion {
        case .success(let json):
          completion(self.mapToObject(json: json))
        case .failure(let error):
          completion(.failure(error))
        }
      })
    } catch let error {
      completion(OperationResult<NetworkModel>.failure(error))
    }
  }

  func mapToObject(json: Any?) -> OperationResult<NetworkModel> {
    guard let jsonData = json as? Data else {
        return OperationResult.failure(APIErrors.incorrectDataType)
    }
    do {
      let object = try JSONDecoder().decode(NetworkModel.self, from: jsonData)
      return OperationResult<NetworkModel>.success(object)
    } catch let error {
      return .failure(APIErrors.deserializationError(error))
    }
  }
}
