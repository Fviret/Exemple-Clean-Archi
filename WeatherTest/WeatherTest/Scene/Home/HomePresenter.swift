//
//  HomePresenter.swift
//  WeatherTest


import UIKit

protocol HomePresentationLogic {
    func presentSomething(response: Home.Something.Response)
}

struct HomePresenter: HomePresentationLogic {
    var viewController: HomeDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Home.Something.Response) {
        let viewModel = Home.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
