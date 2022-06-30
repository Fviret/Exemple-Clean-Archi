//
//  HomeInteractor.swift
//  WeatherTest


import UIKit

protocol HomeBusinessLogic {
    func doSomething(request: Home.Something.Request)
}

protocol HomeDataStore {
//    var name: String { get set }
}

struct HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
//    var name: String = ""
    
    // MARK: Do something

    func doSomething(request: Home.Something.Request) {
        let worker = HomeWorker()
        worker.doSomeWork()

        let response = Home.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
