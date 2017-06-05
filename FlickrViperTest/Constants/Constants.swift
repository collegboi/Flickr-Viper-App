//
//  Constants.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Photo {
        static let searchText = "Party"
    }
    
    struct ErrorAlert {
        static let title = "Error"
        static let message = "We have a problem houston"
        static let actionTitle = "OK"
    }
    
    struct WaitingAlert {
        static let title = "Waiting"
        static let message = "Please wait"
        static let tintColor: UIColor = UIColor.blue
    }
    
    struct CellIdentifiers {
        static let Blue = "BlueCellIdentifier"
        static let Large = "LargeCellIdentifier"
    }
    
    struct FontSizes {
        static let Large: CGFloat = 14.0
        static let Small: CGFloat = 10.0
    }
    
    struct AnimationDurations {
        static let Fast: TimeInterval = 1.0
        static let Medium: TimeInterval = 3.0
        static let Slow: TimeInterval = 5.0
    }
    
    struct Emojis {
        static let Happy = "😄"
        static let Sad = "😢"
    }
    
    struct SegueIdentifiers {
        static let Master = ""
        static let Detail = "ShowDetailVC"
    }
    
}
