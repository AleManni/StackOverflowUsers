//
//  APIRequest.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 16/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation

/**This struct provides an optional URLRequest to be used for network requests.
 ### Usage Example: ###
 ````
 let transactionRequest = APIRequest(endpoint: "5b33bdb43200008f0ad1e256",
 method: .get,
 apiVersion: .version2)
 // let _ = transactionRequest.urlString // "​http://www.mocky.io/v2/5b33bdb43200008f0ad1e256"
 // let _ = transactionRequest.request // The URLRequest
 ````
 */
public struct APIRequestBuilder {
    let base: String
    let endpoint: String
    let ids: [Int]?
    let pathOptionalSuffix: String?
    let parameters: [RequestParameter]?
    let body: BodyType?
    let method: HTTPMethod
    let apiVersion: APIVersion
    var cachePolicy: NSURLRequest.CachePolicy?
    
    // MARK: Accessory enums and alias
    public typealias RequestParameter = (type: RequestParametersType, values: [String])

    public enum APIVersion {
        case unversioned
        case version1
        case version2
        case custom(String)
      
      public var value: String? {
        switch self {
        case .unversioned:
          return nil
        case .version1:
          return "v1"
        case .version2:
          return "v2"
        case let .custom(version):
          return version
        }
      }
    }

    public enum RequestParametersType: Hashable {
        case filter(String)
        case limit
        case query
        case custom(String)
        
        var string: String {
            switch self {
            case .filter(let string):
                return "filter[\(string)]"
            case .limit:
                return "limit"
            case .query:
                return "query"
            case .custom(let string):
                return string
            }
        }
    }

    public enum HTTPMethod: String {
        case post = "POST"
        case put = "PUT"
        case get = "GET"
        case delete = "DELETE"
        case patch = "PATCH"
    }

    public enum BodyType {
        case json([String: Any])
        case form([String: String])
    }

    public enum APIRequestError: Error, CustomStringConvertible {
        case missingURL
        case jsonError(Error)
        
        public var description: String {
            switch self {
            case .missingURL:
                return "Not possible to generate url from the provided components"
            case .jsonError:
                return "Unexpected error while encoding provided body to JSON"
            }
        }
    }
    
    public init(base: String,
         endpoint: String,
         ids: [Int]? = nil,
         pathOptionalSuffix: String? = nil,
         parameters: [RequestParameter]? = nil,
         body: BodyType? = nil,
         method: HTTPMethod = .get,
         apiVersion: APIVersion = .unversioned) {
        self.base = base
        self.endpoint = endpoint
        self.ids = ids
        self.pathOptionalSuffix = pathOptionalSuffix
        self.parameters = parameters
        self.body = body
        self.method = method
        self.apiVersion = apiVersion
    }
}

extension APIRequestBuilder {
    
    public func makeRequest() throws -> URLRequest {
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
               throw APIRequestError.missingURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let body = body, method == .post {
            do {
                switch body {
                case .json(let bodyDict):
                    let jsonData = try JSONSerialization.data(withJSONObject: bodyDict)
                    request.httpBody = jsonData
                    request.addValue("application/vnd.api+json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
                case .form(let bodyDict):
                    let parameterArray = bodyDict.map { (arg) -> String in
                        let (key, value) = arg
                        return "\(key)=\(value.URLEncoded)"
                    }
                    request.httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
                    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                }
            }
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if let cachePolicy = cachePolicy {
            request.cachePolicy = cachePolicy
        }
        return request
    }
    
    private var urlString: String? {
        var components = URLComponents()
        components.scheme = "https"
        components.percentEncodedHost = base
        components.path = path
        components.queryItems = queryItems
        components.percentEncodedQuery = components.percentEncodedQuery?
            .replacingOccurrences(of: "+", with: "%2B")
        return components.string
    }
    
    private var queryItems: [URLQueryItem]? {
        guard let parameters = parameters else {
            return nil
        }
        return parameters.compactMap {
            URLQueryItem(name: $0.0.string, value: $0.1.joined(separator: ","))
        }
    }
    
    private var path: String {
        let separator = "/"
        let idString = ids?.compactMap {
            String($0)
        }.joined(separator: ",")
        
        return separator +
            [apiVersion.value,
             endpoint,
             idString,
             pathOptionalSuffix]
                .compactMap { $0 }
                .joined(separator: separator)
    }
}
