//
//  PhotoSearchInteractor.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation

protocol PhotoSearchInteractorInput: class {
    func fetchAllPhotoosFromDataManager(_ searchText: String, page: NSInteger)
}

protocol PhotoSearchInteractorOutput: class {
    func providePhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func serviceError(_ error: NSError)
}

class PhotoSearchInteractor: PhotoSearchInteractorInput {
    
    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotoosFromDataManager(_ searchText: String, page: NSInteger)  {
        
        APIDataManager.fetchPhotosForSearchText(searchText: searchText, page: page) { (error, page, flickrPhotos) in
            
            if let photos = flickrPhotos {
                self.presenter.providePhotos(photos, totalPages: page)
            } else if let error = error {
                self.presenter.serviceError(error)
            }
        }
    }
    
}
