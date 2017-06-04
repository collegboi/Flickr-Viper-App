//
//  PhotoDetailPresenter.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoDetailPresenterProtocolInput: PhotoDetailInteractorProtocolOutput, PhotoDetailViewControllerOutput {}

class PhotoDetailPresenter: PhotoDetailPresenterProtocolInput {
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorProtocolInput!
    
    //Passing data from PhotoSearch Module Router
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel) {
        self.interactor.configurePhotoModel(photoModel)
    }
    
    func loadLargePhotoImage() {
        self.interactor.loadImageFromURL()
    }
    
    //results from Interactor
    func sendLoadedPhotoImage(_ image: UIImage) {
        self.view.addLargeLoadedPhoto(image)
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.addPhotoImageTitle(imageTitle)
    }
}
