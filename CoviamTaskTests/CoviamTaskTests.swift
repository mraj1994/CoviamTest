//
//  CoviamTaskTests.swift
//  CoviamTaskTests
//
//  Created by QuietGrowth pty ltd on 02/03/20.
//  Copyright © 2020 Mraj singh. All rights reserved.
//

import XCTest

class CoviamTaskTests: XCTestCase {
    
    var session: URLSession!

    override func setUp() {
      super.setUp()
      session = URLSession(configuration: .default)
    }

    override func tearDown() {
      session = nil
      super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    

    func testAPIs(){
        // given
      let url =
        URL(string: "https://www.blibli.com/backend/search/products?searchTerm=samsung&start=0&itemPerPage=24")
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = session.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }

}
