//
//  VideoModelView.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import Foundation

protocol HomeVideoFeedDelegate {
    
    func videoFeedData(_ status: Bool)
}

class HomeViewModel {
    
    var feedDelegate: HomeVideoFeedDelegate?
    
    var videoFeedResult: Video?
    
    var videoFeedFailed: String?
    
    
    func fetchVideoFeed() {
        
        ApiService.sharedInstance.getJSONResponse(urlString: ApiService.sharedInstance.baseUrl, success: { [weak self] (videoModel: Video) in
            
            self?.videoFeedResult = videoModel
            self?.feedDelegate?.videoFeedData(true)
            
        }) { [weak self] (error) in
            print(error)
            self?.videoFeedFailed = error
            self?.feedDelegate?.videoFeedData(false)
        }
    }
    
}
