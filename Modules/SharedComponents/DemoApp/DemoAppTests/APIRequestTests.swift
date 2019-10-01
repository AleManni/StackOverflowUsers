//
//  APIRequestTests.swift
//  DemoAppTests
//
//  Created by Alessandro Manni on 19/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import SharedComponents

class APIRequestTests: XCTestCase {
    
    func testBasicRequest() {
        // GIVEN
        let testRequest = APIRequestBuilder(base: "base.com", endpoint: "5b33bdb43200008f0ad1e256",
                                     method: .get)
        // THEN
        XCTAssertNotNil(try! testRequest.makeRequest())
        XCTAssertEqual(try! testRequest.makeRequest().url?.absoluteString, "https://base.com/5b33bdb43200008f0ad1e256")
    }
    
    func testAPIVersioningRequest() {
        // GIVEN
        let testRequest = APIRequestBuilder(base: "base.com",
                                            endpoint: "5b33bdb43200008f0ad1e256",
                                            method: .get,
                                            apiVersion: .version2)
        // THEN
        XCTAssertNotNil(try! testRequest.makeRequest())
        XCTAssertEqual(try! testRequest.makeRequest().url?.absoluteString, "https://base.com/v2/5b33bdb43200008f0ad1e256")
    }
    
    func testRequestWithParameters() {
        // GIVEN
        let testRequest = APIRequestBuilder(base: "base.com",
                                     endpoint: "5b33bdb43200008f0ad1e256",
                                     parameters: [(.query, ["testQuery"]),
                                                  (.filter("date"), ["testDate"]), (.filter("city"), ["testCity"])],
                                     method: .get)
        // THEN
        XCTAssertNotNil(try! testRequest.makeRequest())
        
        XCTAssertEqual(try! testRequest.makeRequest().url?.absoluteString, "https://base.com/5b33bdb43200008f0ad1e256?query=testQuery&filter%5Bdate%5D=testDate&filter%5Bcity%5D=testCity")
    }
    
    func testRequestPOSTJsonBody() {
        // GIVEN
        let body = APIRequestBuilder.BodyType.json(["testKey":"testValue"])
        let testRequest = APIRequestBuilder(base: "base.com",
                                            endpoint: "5b33bdb43200008f0ad1e256",
                                            body: body,
                                            method: .post)
        //WHEN
        var error: Error?
        var request: URLRequest?
        
        do {
            request = try testRequest.makeRequest()
            
        } catch let thrownError {
            error = thrownError
        }
        
        XCTAssertNil(error)
        XCTAssertNotNil(request?.httpBody)
    }
}
