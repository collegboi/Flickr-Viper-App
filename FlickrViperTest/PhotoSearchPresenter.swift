//
//  PhotoSearchPresenter.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation

protocol PhotoSearchPresenterInput: PhotoViewControllerOutput, PhotoSearchInteractorOutput {
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    weak var view: PhotoViewController!
    var interactor: PhotoSearchInteractorInput!
    
    //Presenter says interactor ViewController
    func fetchPhotos(_ searchText: String, page: NSInteger) {
        
        interactor.fetchAllPhotoosFromDataManager(searchText, page: page)
    }
    
    
    //Service return photos and interactor passes all data to presenter which makes view display them 
    func providePhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.view.displayFetchedPhotos(photos, totalPages: totalPages)
    }
    
    //Show Error from service
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(error.localizedDescription)
    }
}
