//
//  WeatherInteractor.swift
//  WeatherTest


import UIKit

protocol WeatherBusinessLogic {
    func doSomething(request: Weather.Something.Request)
    func displayWaitingMessage(runCount: Int)
    func displayProgress(progression: Int)
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
            let response = Weather.Something.Response(city: request.city, weather: data)
            presenter?.presentSomething(response: response)
        }
    }
    
    // MARK: Display Progress
    func displayProgress(progression: Int) {
        var progressCalc: Float = 0.0
        progressCalc = Float((1.0 * Float(progression)) / 60.0)
        let progressLbl = "\(Float(progression) * 1.9) %"
        
        presenter?.displayProgress(progressionBar: progressCalc, progressionLbl: progressLbl)
    }
    
    // MARK: Display Waiting Message
    func displayWaitingMessage(runCount: Int){
        switch runCount {
        case 0, 18, 36, 54:
            presenter?.displayMessage(message: "Nous téléchargeons les données…")
        case 6, 24, 42:
            presenter?.displayMessage(message: "C’est presque fini…")
        case 12, 30, 48:
            presenter?.displayMessage(message: "Plus que quelques secondes avant d’avoir le résultat…")
        default:
            break
        }
    }
}
