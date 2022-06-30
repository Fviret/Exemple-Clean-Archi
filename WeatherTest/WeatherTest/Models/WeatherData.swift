//
//  WeatherData.swift
//  WeatherTest

import Foundation
import UIKit

struct WeatherData: Codable {
    let coord : Coord
    let weather: [Weathers]
    let main: Temperature
    let wind: Wind
    var name : String
}

struct Coord: Codable {
    let lon: Float
    let lat: Float
}

struct Weathers: Codable {
    let id : Int?
    let main: String
    let description: String
}

struct Temperature: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Float
    let humidity: Float
}

struct Wind: Codable {
    let speed: Float
    let type: Int?
    let country: String?
    
}
