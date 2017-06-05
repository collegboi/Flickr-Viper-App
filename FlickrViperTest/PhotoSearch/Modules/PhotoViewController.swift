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
    func gotoPhotoDetailScreen()
    func passDataToNextScene(_ seque: UIStoryboardSegue)
}

protocol PhotoViewControllerInput {
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func displayErrorView(_ errorMessage: String)
    func showWaitingView()
    func hideWaitingView()
}

class PhotoViewController: UIViewController, PhotoViewControllerInput {

    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    
    var presenter: PhotoViewControllerOutput!
    
    var photos: [FlickrPhotoModel] = []
    var currentPage: NSInteger = 1
    var totalPages: NSInteger = 1
    
//    fileprivate var flickrCollectionDelegate: FlickrCollectionDelegate!
//    fileprivate var flickrCollectionDataSource: FlickrCollectionDataSource!
//    fileprivate var flickrCollectionFlowDelegate: FlickrCollectionFlowDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        PhotoSearchAssembly.sharedInstance.configure(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = Constants.Photo.searchText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //DataSource to load new page
//        flickrCollectionDataSource = FlickrCollectionDataSource(photoCollectionView, performNextSearch: { (pageNumber) in
//            self.performSearchWith(Constants.Photo.searchText, pageNumber)
//        })
//        
//        
//        //Delegate for selecting cell item
//        flickrCollectionDelegate = FlickrCollectionDelegate(photoCollectionView, selectionPhoto: { (flickrModel ) in
//            self.presenter.gotoPhotoDetailScreen()
//        })
//        
//        flickrCollectionFlowDelegate = FlickrCollectionFlowDelegate(photoCollectionView)
        
        
        performSearchWith(Constants.Photo.searchText, self.currentPage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.passDataToNextScene(segue)
    }
    

    func performSearchWith(_ searchText: String, _ pageCount: Int) {
        presenter.fetchPhotos(searchText, page: currentPage)
        
    }
    
    //Presenter return
    func displayFetchedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.photos.append(contentsOf: photos)
        self.totalPages = totalPages
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
            //self.reloadCollectionView()
        }
    }
//    
//    func reloadCollectionView() {
//        self.flickrCollectionDelegate.reloadData(self.photos)
//        self.flickrCollectionFlowDelegate.reloadCount(self.photos.count)
//        self.flickrCollectionDataSource.reloadData(self.photos)
//    }
    
    
    //Show Error 
    func displayErrorView(_ errorMessage: String) {
        
        let refreshAlert = UIAlertController(title: Constants.ErrorAlert.title, message: errorMessage, preferredStyle: .alert)
        refreshAlert.addAction(UIAlertAction(title: Constants.ErrorAlert.actionTitle, style: .default, handler: { (action) in
            refreshAlert.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    //MARK: - Activity View
    func showWaitingView() {
        
        let alert = UIAlertController(title: Constants.WaitingAlert.title, message: Constants.WaitingAlert.message, preferredStyle: .alert)
        
        alert.view.tintColor = Constants.WaitingAlert.tintColor
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideWaitingView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getTotalPhotoCount() -> Int {
        return self.photos.count
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
            performSearchWith(Constants.Photo.searchText, self.currentPage)
            return photoLoadingCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultResuseIdenitifier, for: indexPath as IndexPath) as? PhotoItemCell
        
        let flickrPhoto = self.photos[indexPath.row]
        
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

//MARK: - UICollectionViewDelegate
extension PhotoViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.gotoPhotoDetailScreen()
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



