//
//  Video.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import Foundation

// MARK: - Video
struct Video: Decodable {
    var title: String?
    var rows: [Row]?
}

// MARK: - Row
struct Row: Decodable {
    var title, description: String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref
    }
}


extension Video: Parceable {
    static func parseObject(data: Data) -> Result<Video, ErrorResult> {
        let decoder = JSONDecoder()
        if let result = try? decoder.decode(Video.self, from: data) {
            return Result.success(result)
        } else {
            return Result.failure(ErrorResult.parser(string: "Unable to parse FeedsModel results"))
        }
    }
}
