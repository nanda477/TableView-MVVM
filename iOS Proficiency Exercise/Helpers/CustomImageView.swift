//
//  Extension.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrl(urlString: String) {
        
        imageUrlString = urlString
        
        image = UIImage(named: "placeholder")
        
        guard let url = URL(string: urlString) else{
            // incorrect url
            print("image not found")
            return
        }

        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                if let imgData = data {
                    let imageToCache = UIImage(data: imgData)
                    
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    if imageToCache != nil {
                        imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                    }
                }
                
                
            }
            
        }.resume()
    }
}
