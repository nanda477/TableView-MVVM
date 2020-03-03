//
//  ParserHelper.swift
//  iOS Proficiency Exercise XCTests
//
//  Created by Nanda iMac on 03/03/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(data: Data) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    static func parse<T: Parceable>(data: Data, completion: (Result<[T], ErrorResult>) -> Void) {
        switch T.parseObject(data: data) {
        case .failure(let error):
            completion(.failure(error))
            break
        case .success(let newModel):
            completion(.success([newModel]))
            break
        }
    }

    static func parse<T: Parceable>(data: Data, completion: (Result<T, ErrorResult>) -> Void) {

        if
            let response = String(data: data, encoding: String.Encoding.ascii),
            let data = response.data(using: String.Encoding.utf8)
        {
            switch T.parseObject(data: data) {
            case .failure(let error):
                completion(.failure(error))
                break
            case .success(let newModel):
                completion(.success(newModel))
                break
            }
        } else {
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
}
