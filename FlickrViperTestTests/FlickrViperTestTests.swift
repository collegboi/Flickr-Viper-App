//
//  FlickrViperTestTests.swift
//  FlickrViperTestTests
//
//  Created by Timothy Barnard on 04/06/2017.
//  Copyright © 2017 Timothy Barnard. All rights reserved.
//

import XCTest

@testable import FlickrViperTest

class FlickrViperTestTests: XCTestCase {
    
    var searchString: String = "Party"
    var pageNumber: Int = 1
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLRequest() {
        
        let flickrDataManager = FlickrDataManager()
        
        flickrDataManager.fetchPhotosForSearchText(searchText: searchString, page: pageNumber) { (error, page, photots) in
            
            XCTAssertTrue((photots?.count)! > 0 )
            XCTAssertTrue(page == 1 )
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
