//
//  HomeRouter.swift
//  WeatherTest


import UIKit

protocol HomeRoutingLogic {
    func routeToWheather()
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

struct HomeRouter: HomeRoutingLogic, HomeDataPassing {
    var viewController: HomeViewController?
    var dataStore: HomeDataStore?

    // MARK: Routing
    func routeToWheather() {
        let svc = WeatherViewController()
        viewController?.navigationController?.pushViewController(svc, animated: true)
    }
}
