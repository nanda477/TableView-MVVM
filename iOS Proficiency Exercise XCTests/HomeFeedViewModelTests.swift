//
//  HomeFeedViewModelTests.swift
//  iOS Proficiency Exercise XCTests
//
//  Created by Nanda iMac on 03/03/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import XCTest
import Foundation
@testable import iOS_Proficiency_Exercise

class HomeFeedViewModelTests: XCTestCase {
    /******************************Model Test**********************************/
    func testEmptyFeedsResult() {
           let data = Data()
           let completion: ((Result<Video, ErrorResult>) -> Void) = { result in
               switch result {
               case .success:
                   XCTAssert(false, "Expected failure when no data")
               default:
                   break
               }
           }
           ParserHelper.parse(data: data, completion: completion)
       }
    
    // test it for static data
    func testParseFeedsResult() {
        let data = MockFeedData().getfeedData()
          let completion: ((Result<Video, ErrorResult>) -> Void) = { result in
              switch result {
              case .failure:
                  XCTAssert(false, "Expected valid FeedsModel")
              case .success(let response):
                  XCTAssertEqual(response.title, "About Canada", "Expected About Canada")
                  if let list = response.rows {
                    // success case
                      XCTAssertEqual(list.count, 14, "Expected 14 rows")
                    // failure case
                    // XCTAssertEqual(list.count, 140, "Expected 14 rows")

                  } else {
                      XCTAssert(false, "Expected valid ListModel")
                  }
              }
          }
          ParserHelper.parse(data: data, completion: completion)
      }
    
    
    func testWrongKeyFeedsResult() {
        let data = Data()
        let result = Video.parseObject(data: data)
        switch result {
        case .success:
            XCTAssert(false, "Expected failure when wrong data formate")
        default:
            return
        }
    }
    
}
