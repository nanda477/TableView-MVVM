//
//  Video.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import Foundation

// MARK: - Video
struct Video: Codable {
    var title: String?
    var rows: [Row]?
}

// MARK: - Row
struct Row: Codable {
    var title, description: String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
}
