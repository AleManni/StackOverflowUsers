//
//  DomainModel.swift
//  SharedComponents
//
//  Created by Alessandro Manni on 16/08/2018.
//  Copyright © 2018 Alessandro Manni. All rights reserved.
//

import Foundation
/**
 This empty protocol is implemented by the data domain model classes in order to clarify their responsability in the  current data binding architecture.
 The Domain Models are often simply referred to as Models in other implementations.
 */

public protocol DomainModel {
}

extension Array: DomainModel {
}
