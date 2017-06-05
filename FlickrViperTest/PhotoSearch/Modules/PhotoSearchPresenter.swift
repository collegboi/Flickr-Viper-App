//
//  PhotoSearchPresenter.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoSearchPresenterInput: PhotoViewControllerOutput, PhotoSearchInteractorOutput {
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    weak var view: PhotoViewController!
    var interactor: PhotoSearchInteractorInput!
    var router: PhotoSearchRouterInput!
    
    //Presenter says interactor ViewController
    func fetchPhotos(_ searchText: String, page: NSInteger) {
        
        if view.getTotalPhotoCount() == 0 {
            view.showWaitingView()
        }
        
        interactor.fetchAllPhotoosFromDataManager(searchText, page: page)
    }
    
    
    //Service return photos and interactor passes all data to presenter which makes view display them 
    func providePhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalPages: totalPages)
    }
    
    //Show Error from service
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(error.localizedDescription)
    }
    
    func gotoPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    func passDataToNextScene(_ seque: UIStoryboardSegue) {
        self.router.passDataToNextScene(seque)
    }
}
