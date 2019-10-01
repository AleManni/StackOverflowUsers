//
//  NetworkResult.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 19/07/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation

public enum NetworkResult {
  case success(Any?)
  case failure(Error)
}
