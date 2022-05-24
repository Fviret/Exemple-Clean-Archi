//
//  WeatherInteractor.swift
//  WeatherTest


import UIKit

protocol WeatherBusinessLogic {
    func doSomething(request: Weather.Something.Request)
}

protocol WeatherDataStore {
}

struct WeatherInteractor: WeatherBusinessLogic, WeatherDataStore {
    var presenter: WeatherPresentationLogic?

    // MARK: Do something

    func doSomething(request: Weather.Something.Request) {
        let worker = WeatherWorker()
        worker.doSomeWork(url: "https://api.openweathermap.org/data/2.5/weather?q=\(request.city)&appid=92a4a2490465fa9d45f8bb6f57558c05") { data, error in
            guard let data = data else {
                print(error)
                return
            }
            
//            print(String(data: [WeatherData], encoding: .utf8))
            let response = Weather.Something.Response(city: request.city, weather: data)
            presenter?.presentSomething(response: response)
        }
    }
}
