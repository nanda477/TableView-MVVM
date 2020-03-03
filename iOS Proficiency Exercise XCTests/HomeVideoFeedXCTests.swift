//
//  HomeVideoFeedXCTests.swift
//  iOS Proficiency Exercise XCTests
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

@testable import iOS_Proficiency_Exercise

import XCTest

class HomeVideoFeedXCTests: XCTestCase {
    
    
    //Model Stucture checking
//    func testFetchVideoFeed() throws {
//        
//        let firstRow = Row(title: "firstvideo", description: "its a short video about ios", imageHref: "https://ios.jpg")
//        let secondRow = Row(title: "secondvideo", description: "its a video about ios", imageHref: "https://apple.jpg")
//
//        let video = Video(title: "title", rows: [firstRow, secondRow])
//        let jsonEncoder = JSONEncoder()
//        let videosData = try jsonEncoder.encode(video)
//
//        //positive case
//        XCTAssertNotNil(videosData)
//        //negative case
//        // XCTAssertNil(videosData)
//    }
    
    
    func testVideoModel() {
        let firstRow = Row(title: "firstvideo", description: "its a short video about ios", imageHref: "https://ios.jpg")
        let secondRow = Row(title: "secondvideo", description: "its a video about ios", imageHref: "https://apple.jpg")
        
        let video = Video(title: "title", rows: [firstRow, secondRow])
        //positive case
        //XCTAssertTrue(video.rows!.count > 0) or
        XCTAssertEqual(video.rows!.count, 2)
        
        //negative case
        //XCTAssertEqual(video.rows!.count, 0)
    }
    
    func testImageUrlNotEmpty() throws {
        
        let demoRow = Row(title: "firstvideo", description: "its a short video about ios", imageHref: "https://ios.jpg")
        
        let viewModel = Video(title: "title", rows: [demoRow])
        
        let imageUrl =  try XCTUnwrap(viewModel.rows?[0].imageHref)
        
        // -ve case
        // let expectedResult = "https://ios.jp"
        // XCTAssertEqual(imageUrl, expectedResult)
        
        //+ve case
        let expectedResult = "https://ios.jpg"
        XCTAssertEqual(imageUrl, expectedResult)
        
    }
    
    
    func testFetchVideoFeedFromApiService() {
        
        
        ApiService.sharedInstance.getJSONResponse(urlString: ApiService.sharedInstance.baseUrl, success: { (videoModel: Video)  in
            // +ve case
            XCTAssertNotNil(videoModel)
            //-ve case
            //XCTAssertNil(videoModel)
        }) { (error) in
    
            XCTFail(error)
        }
    }
    
    // call videos list api
    func testFetchVideoFeedResponse() throws {
        
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            XCTAssertNil(error)
            
            do {
                guard let data = data else {
                    XCTFail()
                    return
                    
                }
                
                let encodeResponseData = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedResponseData = encodeResponseData?.data(using: String.Encoding.utf8) else {
                    
                    //could not Encode data
                    return
                }
                
                let decoder = JSONDecoder()
                let videos = try decoder.decode(Video.self, from: modifiedResponseData)
                XCTAssertNotNil(videos)
                
            } catch let jsonError {
                
                XCTFail(jsonError.localizedDescription)
            }
        }.resume()
    }
    
    
}

