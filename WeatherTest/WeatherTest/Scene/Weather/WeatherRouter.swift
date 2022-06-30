//
//  WeatherRouter.swift
//  WeatherTest


import UIKit

protocol WeatherRoutingLogic {
//    func routeToSomewhere()
}

protocol WeatherDataPassing {
    var dataStore: WeatherDataStore? { get }
}

struct WeatherRouter: WeatherRoutingLogic, WeatherDataPassing {
    var viewController: WeatherViewController?
    var dataStore: WeatherDataStore?

  
}
