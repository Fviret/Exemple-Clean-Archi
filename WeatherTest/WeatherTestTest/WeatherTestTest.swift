//
//  WeatherTestTest.swift
//  WeatherTestTest

import XCTest
@testable import WeatherTest

class WeatherTest: XCTestCase {
    
    var wvc : WeatherViewController!
    var cityWeathersTest : [WeatherData]!

    override func setUpWithError() throws {
        try super.setUpWithError()
        wvc = WeatherViewController()
        cityWeathersTest = [WeatherData(coord: Coord(lon: -1.6667, lat: 48.1667), weather: [Weathers(id: 804, main: "Clouds", description: "overcast clouds")], main: Temperature(temp: 296.79, feels_like: 296.52, temp_min: 292.36, temp_max: 297.17, pressure: 1007.0, humidity: 50.0), wind: Wind(speed: 4.12, type: nil, country: nil), name: "Arrondissement de Rennes")]
        cityWeathersTest = [WeatherData(coord: Coord(lon: -1.6667, lat: 48.1667), weather: [Weathers(id: 804, main: "Clouds", description: "overcast clouds")], main: Temperature(temp: 296.79, feels_like: 296.52, temp_min: 292.36, temp_max: 297.17, pressure: 1007.0, humidity: 50.0), wind: Wind(speed: 4.12, type: nil, country: nil), name: "Arrondissement de Rennes")]
        cityWeathersTest = [WeatherData(coord: Coord(lon: -1.6667, lat: 48.1667), weather: [Weathers(id: 804, main: "Clouds", description: "overcast clouds")], main: Temperature(temp: 296.79, feels_like: 296.52, temp_min: 292.36, temp_max: 297.17, pressure: 1007.0, humidity: 50.0), wind: Wind(speed: 4.12, type: nil, country: nil), name: "Arrondissement de Rennes")]
        cityWeathersTest = [WeatherData(coord: Coord(lon: -1.6667, lat: 48.1667), weather: [Weathers(id: 804, main: "Clouds", description: "overcast clouds")], main: Temperature(temp: 296.79, feels_like: 296.52, temp_min: 292.36, temp_max: 297.17, pressure: 1007.0, humidity: 50.0), wind: Wind(speed: 4.12, type: nil, country: nil), name: "Arrondissement de Rennes")]
        
        
        let localContainer = UIView(frame: wvc.view.frame)
        localContainer.addSubview(wvc.view)
    }

    override func tearDownWithError() throws {
        wvc = nil
        
        try super.tearDownWithError()
    }
    
    func testTest() {
        XCTAssert(!cityWeathersTest.isEmpty)
        XCTAssert(wvc.tableview.numberOfRows(inSection: 0) == 0)
        XCTAssert(!wvc.ProgressBar.isHidden , "The ProgressBar is visible while the tableview is showing")
    }
    
    func testButton(){

        XCTAssert(!cityWeathersTest.isEmpty)
        wvc.actionBtn(wvc.repeatBtn)
        XCTAssert(!wvc.ProgressBar.isHidden, "the progress bar is not visible when the button is tapped")
        XCTAssert(!wvc.ProgressLbl.isHidden, "the progress label is not visible when the button is tapped")
        XCTAssert(!wvc.loader.isHidden)
        
    }

}
