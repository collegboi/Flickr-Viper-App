//
//  SettingsManager.swift
//  FlickrViperTest
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import Foundation


class SettingsManager {
    
    private static let fileName = "Settings"
    
    private struct SettingsKey {
        static let serverKey = "serverKey"
    }
    
    private static func readPlistFile() -> [String: AnyObject]? {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            return dict
        }
        return nil
    }
    
    public static func readServerKey() -> String {
        
        guard let dict = readPlistFile() else {return ""}

        return dict[SettingsKey.serverKey] as? String ?? ""
    }
}
