//
//  FlickrCollectionDataSource.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 05/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

typealias SelectionPhoto = (_ photoSelected: FlickrPhotoModel ) -> Void

class FlickrCollectionDelegate: NSObject {
    
    var allPhotos: [FlickrPhotoModel] = []
    
    fileprivate var collectionView: UICollectionView
    var selectionPhoto: SelectionPhoto?
    
    init(_ collectionView: UICollectionView, selectionPhoto: @escaping SelectionPhoto) {
        self.collectionView = collectionView
        self.selectionPhoto = selectionPhoto
        super.init()
        self.collectionView.delegate = self
    }
    
    func reloadData(_ allPhotos: [FlickrPhotoModel]) {
        self.allPhotos = allPhotos
        self.collectionView.reloadData()
    }
    
}

extension FlickrCollectionDelegate: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.presenter.gotoPhotoDetailScreen()
        selectionPhoto?(self.allPhotos[indexPath.row])
    }
}
