//
//  Home.swift
//  WeatherTestTest

import XCTest
@testable import WeatherTest

class Home: XCTestCase {
    var hvc : HomeViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let localContainer = UIView(frame: hvc.view.frame)
        localContainer.addSubview(hvc.view)
    }

    override func tearDownWithError() throws {
        hvc = nil
        
        try super.tearDownWithError()
    }

}
