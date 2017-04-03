//
//  FlickrService.swift
//  Gallery
//
//  Created by Apple on 24/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import UIKit

struct PhotoFromURL {
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    var size: String = "n"
    
    var photoUrl: NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }
}


class FlickrService {
    
    class func getJSONData(url: String, callback: @escaping ([PhotoFromURL]?) -> Void) {
        
        let session = URLSession.shared
        let jsonURL = URL(string: url)
        
        var request = URLRequest(url: jsonURL!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let getImagesURLS = session.dataTask(with: jsonURL!) {
            (data, response, error) in
            guard error == nil else {
                print(error!)
                return
            }
            
            guard let data = data else {
                print("missing data")
                return
            }
            
            let photos = try? JSONSerialization.jsonObject(with: data, options: []) as!  [String: AnyObject]
            
            
            guard let photosContainer = photos!["photos"] as? NSDictionary else { return }
            guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
            
            let PhotosFromURL: [PhotoFromURL] = photosArray.map { photoDictionary in
                
                let photoId = photoDictionary["id"] as? String ?? ""
                let farm = photoDictionary["farm"] as? Int ?? 0
                let secret = photoDictionary["secret"] as? String ?? ""
                let server = photoDictionary["server"] as? String ?? ""
                let title = photoDictionary["title"] as? String ?? ""
                
                let flickrPhoto = PhotoFromURL(photoId: photoId, farm: farm, secret: secret, server: server, title: title, size: "n")
                
                return flickrPhoto
            }
            
            callback(PhotosFromURL)
        }
        
        getImagesURLS.resume()
        
    }
    
    
    class func getDataFromUrl(url: URL, calldack: @escaping (_ data: Data?) -> Void) {
        
        let session = URLSession.shared
        let getData = session.dataTask(with: url) {
            (data, response, error) in
            calldack(data)
        }
        getData.resume()
        
    }
        
}
