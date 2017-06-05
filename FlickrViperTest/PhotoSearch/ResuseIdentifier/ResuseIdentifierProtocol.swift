//
//  ResuseIdentifierProtocol.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation
import UIKit

public protocol ResuseIdentifierProtocol: class {
    
    //GET indentifier
    
    static var defaultResuseIdenitifier: String  {
        get
    }
    
}

public extension ResuseIdentifierProtocol where Self: UIView {
    
    static var defaultResuseIdenitifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
