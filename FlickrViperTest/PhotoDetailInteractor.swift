//
//  PhotoDetailInteractor.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoDetailInteractorProtocolOutput: class {
    func sendLoadedPhotoImage(_ image: UIImage)
}

protocol PhotoDetailInteractorProtocolInput: class {
    func configurePhotoModel(_ photoModel: FlickrPhotoModel)
    func loadImageFromURL()
    func getPhotoImageTitle() -> String
}

class PhotoDetailInteractor: PhotoDetailInteractorProtocolInput {

    weak var presenter: PhotoDetailInteractorProtocolOutput!
    var photoModel: FlickrPhotoModel?
    var imageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configurePhotoModel(_ photoModel: FlickrPhotoModel) {
        self.photoModel = photoModel
    }
    
    func loadImageFromURL() {
        imageDataManager.loadImageFromURL((self.photoModel?.largePhotoURL)!) { (image, error) in
            if error == nil {
                if let image = image {
                    self.presenter.sendLoadedPhotoImage(image)
                }
            }
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.photoModel?.title {
            return title
        } else {
            return ""
        }
    }

}
