//
//  PhotoDetailAssembly.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController ) {
        
        let APIDataManager: FlickrPhotoLoadImageProtocol = FlickrDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        interactor.imageDataManager = APIDataManager
        
    }
}
