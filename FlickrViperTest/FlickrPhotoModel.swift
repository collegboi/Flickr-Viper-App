//
//  FlickrPhotoModel.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation

struct FlickrPhotoModel {
    
    let photoID: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    enum FlickrPhotoKeys: String {
        case photoID = "id"
        case farm = "farm"
        case secret = "secret"
        case server = "server"
        case title = "title"
    }
    
    init( dict: NSDictionary ) {
        
        self.photoID = dict[FlickrPhotoKeys.photoID.rawValue] as? String ?? ""
        self.farm = dict[FlickrPhotoKeys.farm.rawValue] as? Int ?? 0
        self.secret = dict[FlickrPhotoKeys.secret.rawValue] as? String ?? ""
        self.server = dict[FlickrPhotoKeys.server.rawValue] as? String ?? ""
        self.title = dict[FlickrPhotoKeys.title.rawValue] as? String ?? ""
    }
    
    var photoURL: NSURL {
        return flickrImageURL()
    }
    
    var largePhotoURL: NSURL {
        return flickrImageURL("b")
    }
    
    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    //https://farm5.staticflickr.com/4235/34255514784_4235_.jpg
    
    private func flickrImageURL(_ size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
    }
    
}
