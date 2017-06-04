//
//  FlickrDataManager.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol FlickrPhotoSearchProtocol: class {
    func fetchPhotosForSearchText(searchText:String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]? ) -> Void ) -> Void
}

protocol FlickrPhotoLoadImageProtocol: class {
    func loadImageFromURL(_ url: NSURL, completionHandler: @escaping (UIImage?, NSError? ) -> Void )
}

class FlickrDataManager: FlickrPhotoSearchProtocol, FlickrPhotoLoadImageProtocol {
    
    //static let sharedInstance = FlickrDataManager()
    
    struct Errors {
        static let InvalidAccessErrorCode = 100
    }
    
    struct FlickrAPIMetadataKey {
        static let failureStatus = "code"
        static let photosCode = "photos"
        static let pageCode = "total"
        static let photoCode = "photo"
    }
    
    struct FlickrAPI {
        static let APIKey = SettingsManager.readServerKey()
        static let tagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
    }
    
    func fetchPhotosForSearchText(searchText:String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]? ) -> Void ) -> Void {
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickrAPI.tagsSearchFormat
        //let arguments: [CVarArg] = [FlickrAPI.APIKey, escapedSearchText!, page]
        
        let photosURL = String(format: format, FlickrAPI.APIKey, escapedSearchText!, page)
        
        let url = NSURL(string: photosURL)!
        
        let request = URLRequest(url: url as URL)
        
        
        let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                print("Error fetching photos: \(String(describing: error))")
                closure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                
                guard let results = resultsDictionary else {return}
                
                if let statusCode = results[FlickrAPIMetadataKey.failureStatus] as? Int {
                    
                    if statusCode == Errors.InvalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "FlickrAPIDomain", code: statusCode, userInfo: nil)
                        closure(invalidAccessError, 0, nil)
                    }
                }
                
                guard let photosContainer = results[FlickrAPIMetadataKey.photosCode] as? NSDictionary else {return}
                guard let totalPageCountString = photosContainer[FlickrAPIMetadataKey.pageCode] as? String else {return}
                guard let totalPageCount = NSInteger(totalPageCountString as String) else {return}
                
                guard let photosArray = photosContainer[FlickrAPIMetadataKey.photoCode] as? [NSDictionary] else {return}
                
                let flickerPhotos: [FlickrPhotoModel] = photosArray.map({ (photoDictionary) -> FlickrPhotoModel in
                    
                    let flickrPhoto = FlickrPhotoModel(dict: photoDictionary)
                    
                    return flickrPhoto
                })
                
                closure(nil, totalPageCount , flickerPhotos)
                
            } catch let error as NSError {
                print("Error parsing JSON: \(String(describing: error))")
                closure(error as NSError?, 0, nil)
            }
        }
        
        searchTask.resume()
    }
    
    //Memory Cache Photo Services
    
    func loadImageFromURL(_ url: NSURL, completionHandler: @escaping (UIImage?, NSError? ) -> Void ) {
        
        let request = URLRequest(url: url as URL)
        
        
        let imageTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data , error == nil else {
                completionHandler(nil, error as NSError?)
                return
            }
            let image = UIImage(data: data)
            completionHandler(image, nil)
        }
        
        imageTask.resume()
      
    }
}
