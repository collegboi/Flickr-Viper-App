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
        
        self.photoID = dict[FlickrPhotoKeys.photoID] as? String ?? ""
        self.farm = dict[FlickrPhotoKeys.farm] as? Int ?? 0
        self.secret = dict[FlickrPhotoKeys.secret] as? String ?? ""
        self.server = dict[FlickrPhotoKeys.server] as? String ?? ""
        self.title = dict[FlickrPhotoKeys.title] as? String ?? ""
    }
    
    var photoURL: NSURL {
        return flickrImageURL()
    }
    
    var largePhotoURL: NSURL {
        return flickrImageURL("b")
    }
    
    //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    
    private func flickrImageURL(_ size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(server)_\(size).jpg")!
    }
    
    
    
}
