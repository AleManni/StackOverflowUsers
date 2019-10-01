//
//  ImageDownloaderTests.swift
//  DemoAppTests
//
//  Created by Alessandro Manni on 19/09/2019.
//  Copyright © 2019 Alessandro Manni. All rights reserved.
//

import XCTest
@testable import SharedComponents

class ImageDownloaderTests: XCTestCase {
  
  let configurator = MockNetworkConfigurator()
  
  func testServiceFetchImage() {
    // GIVEN
    let network = MockImageNetworkClient(configuration: configurator.configurationForCurrentEnvironment)
    let netService = NetworkService(networkClient: network, configurator: configurator)
    let downloader = ImageDownloader(networkService: netService)
    let mockURLString = "www.test.com"
    
    let expect = expectation(description: "image fetched")
    // WHEN
    downloader.downloadImage(mockURLString, completion: { image in
      expect.fulfill()
      // THEN
      XCTAssertNotNil(image)
    })
    
    wait(for: [expect], timeout: 2)
  }
}
