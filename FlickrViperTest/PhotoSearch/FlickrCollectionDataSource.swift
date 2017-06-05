//
//  FlickrCollectionDelegate.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 05/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

typealias PerformNextSearch = (_ pageNumber: Int ) -> Void

class FlickrCollectionDataSource: NSObject {
    
    var currentPage: NSInteger = 1
    var totalPages: NSInteger = 1
    
    var allPhotos: [FlickrPhotoModel] = []
    
    fileprivate var collectionView: UICollectionView
    var performNextSearch: PerformNextSearch?
    
    init(_  collectionView: UICollectionView, performNextSearch: @escaping PerformNextSearch ) {
        self.collectionView = collectionView
        self.performNextSearch = performNextSearch
        super.init()
        self.collectionView.dataSource = self
    }
    
    func reloadData (_ allPhotos: [FlickrPhotoModel] = [] ) {
        self.allPhotos = allPhotos
        self.collectionView.reloadData()
    }
}

extension FlickrCollectionDataSource: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Photo cell + loading cell
        if currentPage < totalPages {
            return self.allPhotos.count + 1
        } else {
            return self.allPhotos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < allPhotos.count {
            return photoItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        } else {
            currentPage += 1
            performNextSearch?(currentPage)
            //performSearchWith(Constants.Photo.searchText)
            return photoLoadingCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultResuseIdenitifier, for: indexPath as IndexPath) as? PhotoItemCell
        
        let flickrPhoto = self.allPhotos[indexPath.row]
        
        cell?.photoImageView.alpha = 0
        cell?.photoImageView.sd_setImage(with: flickrPhoto.photoURL as URL, completed: { (image, error, imageCache, url) in
            
            cell?.photoImageView.image = image
            UIView.animate(withDuration: 0.2, animations: {
                cell?.photoImageView.alpha = 1.0
            })
        })
        
        return cell!
    }
    
    func photoLoadingCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultResuseIdenitifier, for: indexPath as IndexPath) as? PhotoLoadingCell
        return cell!
    }

}
