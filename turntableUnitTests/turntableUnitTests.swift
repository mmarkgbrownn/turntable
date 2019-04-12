//
//  turntableUnitTests.swift
//  turntableUnitTests
//
//  Created by Mark Brown on 12/04/2019.
//  Copyright © 2019 Mark Brown. All rights reserved.
//

import XCTest

class turntableUnitTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFormatDuration() {
        // Test the duration format function to ensure that numbers in ms are
        // correctly coverted to mm:ss.
    }

    func testTitleFormat() {
        // Test to ensure that session names arent empty or contain spaces at
        // the beginning or end
    }
    
    func testCreateSession() {
        // Create a test session and ensure all the correct objects are set. This includes session keys
        // and attendee session key
    }
    
    func testObserverResponse() {
        // Begin an observation and check for the correct response. This is makes sure that
        // sessionQueue objects are reobtained by firebase correctly.
        
    }
    
    func testJoinSessionMethod() {
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
