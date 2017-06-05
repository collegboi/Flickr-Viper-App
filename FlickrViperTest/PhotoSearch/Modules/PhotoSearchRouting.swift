//
//  PhotoSearchRouting.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

protocol PhotoSearchRouterInput {
    func navigateToPhotoDetail()
    func passDataToNextScene(_ seque: UIStoryboardSegue)
}


class PhotoSearchRouting: PhotoSearchRouterInput {
    
    weak var viewController: PhotoViewController!
    
    //MARK:- Navigation 
    func navigateToPhotoDetail() {
        viewController.performSegue(withIdentifier: Constants.SegueIdentifiers.Detail, sender: nil)
    }
    
    func passDataToNextScene(_ seque: UIStoryboardSegue) {
        if seque.identifier == Constants.SegueIdentifiers.Detail {
            passDataToShowProtocolDetailScene(seque)
        }
    }
    
    //navigate to another module
    func passDataToShowProtocolDetailScene(_ seque: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let selectedPhotoModel = viewController.photos[selectedIndexPath.row]
            let showDetailViewController = seque.destination as! PhotoDetailViewController
            
            showDetailViewController.presenter.saveSelectedPhotoModel(selectedPhotoModel)
        }
    }
}
