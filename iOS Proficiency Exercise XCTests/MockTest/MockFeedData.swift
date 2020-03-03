//
//  MockFeedData.swift
//  iOS Proficiency Exercise XCTests
//
//  Created by Nanda iMac on 03/03/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import XCTest
@testable import iOS_Proficiency_Exercise
                                    //********* Checking static data **************//
class MockFeedData {
    
    
    func getfeedData() -> Data {
         guard let data = self.readJson(forResource: "feed") else {
             XCTAssert(false, "Can't get data from feed.json")
             return Data()
         }
         return data
     }

     func getFeeds() -> Video {
         var responseResults: Video!
         guard let data = self.readJson(forResource: "feed") else {
             XCTAssert(false, "Can't get data from feed.json")
             return Video(title: "test Title", rows: nil)
         }
         let completion: ((Result<Video, ErrorResult>) -> Void) = { result in
             switch result {
             case .failure:
                 XCTAssert(false, "Expected valid converter")
             case .success(let result):
                 responseResults = result
                 break
             }
         }
        
         ParserHelper.parse(data: data, completion: completion)
         return responseResults
     }

     func getFeedslist() -> [Row] {
         guard let list = getFeeds().rows else {
             return [Row(title: "title", description: "description", imageHref: "imageHref")]
         }
         return list
     }
    
    
}

extension MockFeedData {
    func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            XCTFail("Missing file: \(fileName).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch (_) {
            XCTFail("unable to read json")
            return nil
        }
    }
}
