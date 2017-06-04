//
//  DetailViewController.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInput: class {
    func addLargeLoadedPhoto(_ photo: UIImage)
    func addPhotoImageTitle(_ title: String)
}

protocol PhotoDetailViewControllerOutput: class {
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

class PhotoDetailViewController: UIViewController {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoUIImageView: UIImageView!
    
    var presenter: PhotoDetailViewControllerOutput!

    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoDetailAssembly.sharedInstance.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension PhotoDetailViewController: PhotoDetailViewControllerInput {
    func addPhotoImageTitle(_ title: String) {
        self.photoTitleLabel.text = title
    }

    func addLargeLoadedPhoto(_ photo: UIImage) {
        self.photoUIImageView.image = photo
    }
}
