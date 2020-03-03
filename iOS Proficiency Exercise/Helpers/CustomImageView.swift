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
        
        guard let url = URL(string: urlString) else{
            // incorrect url
            self.image = UIImage(named: "placeholder")!
            imageCache.setObject(UIImage(named: "placeholder")!, forKey: urlString as NSString)
            return
        }
        // if already stored in cache
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            // if any error occured
            if error != nil {
               
                DispatchQueue.main.async {
                    imageCache.setObject(UIImage(named: "placeholder")!, forKey: urlString as NSString)
                    self.image = UIImage(named: "placeholder")!
                }
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
                    }else{
                        // image not available
                        self.image = UIImage(named: "placeholder")!
                        imageCache.setObject(UIImage(named: "placeholder")!, forKey: urlString as NSString)
                    }
                    
                }else{
                    // data not availabe
                     self.image = UIImage(named: "placeholder")!
                     imageCache.setObject(UIImage(named: "placeholder")!, forKey: urlString as NSString)
                }
                
                
            }
            
        }.resume()
    }
}
