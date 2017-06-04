//
//  PhotoViewController.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import UIKit

protocol PhotoViewControllerOutput {
    func fetchPhotos(_ searchText: String, page: NSInteger)
}

protocol PhotoViewControllerInput {
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func displayErrorView(_ errorMessage: String)
}

class PhotoViewController: UIViewController, PhotoViewControllerInput {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    var presenter: PhotoViewControllerOutput!
    
    var photos: [FlickrPhotoModel] = []
    var currentPage: NSInteger = 1
    var totalPages: NSInteger = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Party"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        performSearchWith("Party")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func performSearchWith(_ searchText: String) {
        presenter.fetchPhotos(searchText, page: currentPage)
        
    }
    
    //Presenter return
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.photos.append(contentsOf: photos)
        self.totalPages = totalPages
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
        }
    }
    
    
    //Show Error 
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension PhotoViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Photo cell + loading cell
        if currentPage < totalPages {
            return self.photos.count + 1
        } else {
            return self.photos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if indexPath.row < photos.count {
            return photoItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        } else {
            
            currentPage += 1
            performSearchWith("Party")
            return photoLoadingCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultResuseIdenitifier, for: indexPath as IndexPath) as? PhotoItemCell
        return cell!
    }
    
    func photoLoadingCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultResuseIdenitifier, for: indexPath as IndexPath) as? PhotoLoadingCell
        return cell!
    }
    
}

//MARK: - UICollectionViewDelegate
extension PhotoViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let length = (UIScreen.main.bounds.width) / 3 - 1
        
        if indexPath.row < self.photos.count {
            itemSize = CGSize(width: length, height: length)
        } else {
            itemSize = CGSize(width: photoCollectionView.bounds.width, height: 50)
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


