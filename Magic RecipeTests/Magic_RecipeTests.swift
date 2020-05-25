//
//  Magic_RecipeTests.swift
//  Magic RecipeTests
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import XCTest
@testable import Magic_Recipe

class Magic_RecipeTests: XCTestCase {

    var systemUnderTest: ConnectionManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        systemUnderTest = ConnectionManager()
        systemUnderTest.fetchData(ing: "dgdrg", page: 1)
        
    }
    
    override func tearDown() {
        systemUnderTest = nil
        super.tearDown()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testFetchData(){
        var ingredients = "onion"
        var res = systemUnderTest.fetchData(ing: ingredients, page: 1)
//        XCTAssertEqual(res,)
        
    }

}
