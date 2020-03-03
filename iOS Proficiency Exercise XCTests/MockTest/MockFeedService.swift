//
//  MockFeedService.swift
//  iOS Proficiency Exercise XCTests
//
//  Created by Nanda iMac on 03/03/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import Foundation
@testable import iOS_Proficiency_Exercise

class MockFeedService {
    
  var viewModel: Video?
     
     func fetchFeeds(_ completion: @escaping ((Result<Video, Error>) -> Void)) {
           if let data = viewModel {
               completion(Result.success(data))
           } else {
               completion(Result.failure(ErrorResult.custom(string: "Bad data formate")))
           }
       }
}
