//
//  WeatherPresenter.swift
//  WeatherTest


import UIKit

protocol WeatherPresentationLogic {
    func presentSomething(response: Weather.Something.Response)
}

struct WeatherPresenter: WeatherPresentationLogic {
    var viewController: WeatherDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Weather.Something.Response) {
//        print(response)
        let viewModel = Weather.Something.ViewModel(responseToController: response.weather)
       
        viewController?.displaySomething(viewModel: viewModel)
    }
}
