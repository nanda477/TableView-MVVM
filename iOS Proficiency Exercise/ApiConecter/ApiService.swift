//
//  ApiService.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    
    func getJSONResponse<T: Decodable>(urlString: String, success: @escaping (_ response: T) -> (), failure: @escaping(_ error: String)-> ()) {
        
        guard Utilities.isInternetActive() else {
            failure("Please check your internet connection")
            return
        }
        
        guard let url = URL(string: urlString) else {
            failure("Something went wrong")
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if error != nil {
                failure(error?.localizedDescription ?? "Error")
                return
            }
            
            do {
                guard let data = data else { return }
                
                let encodeResponseData = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedResponseData = encodeResponseData?.data(using: String.Encoding.utf8) else {
                    
                    failure("could not Encode data")
                    return
                }
                
                let decoder = JSONDecoder()
                let videos  = try decoder.decode(T.self, from: modifiedResponseData)
                print(videos)
                DispatchQueue.main.async {
                    success(videos)
                }
                
            } catch let jsonError {
                
                DispatchQueue.main.async {
                    failure(jsonError.localizedDescription)
                }
            }
        }.resume()
        
    }
}
