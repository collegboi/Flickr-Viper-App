//
//  FlickrCollectionFlowDelegate.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 05/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

class FlickrCollectionFlowDelegate: NSObject {
    
    fileprivate var collectionView: UICollectionView
    var count: Int = 0
    
    init(_ collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
        self.collectionView.delegate = self
    }
    
    func reloadCount(_ count: Int) {
        self.count = count
        self.collectionView.reloadData()
    }
    
}

extension FlickrCollectionFlowDelegate: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let length = (UIScreen.main.bounds.width) / 3 - 1
        
        if indexPath.row < count {
            itemSize = CGSize(width: length, height: length)
        } else {
            itemSize = CGSize(width: collectionView.bounds.width, height: 50)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }

    
}
