//
//  WeatherPresenter.swift
//  WeatherTest


import UIKit

protocol WeatherPresentationLogic {
    func presentSomething(response: Weather.Something.Response)
    func displayMessage(message : String)
    func displayProgress(progressionBar: Float, progressionLbl: String)
}

struct WeatherPresenter: WeatherPresentationLogic {
    var viewController: WeatherDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Weather.Something.Response) {
        let viewModel = Weather.Something.ViewModel(responseToController: response.weather)
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func displayMessage(message : String) {
        self.viewController?.displayMessage(message: message)
    }
    
    func displayProgress(progressionBar: Float, progressionLbl: String){
        self.viewController?.displayProgress(progressionBar: progressionBar, progressionLbl: progressionLbl)
    }
}
