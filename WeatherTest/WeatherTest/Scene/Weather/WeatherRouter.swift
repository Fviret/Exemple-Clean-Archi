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

    // MARK: Routing

//    func routeToSomewhere() {
//        let svc = SomewhereViewController()
//        viewController?.navigationController.push(viewController, animated: true)
//    }
}
