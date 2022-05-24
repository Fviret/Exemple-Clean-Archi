//
//  WeatherModels.swift
//  WeatherTest

import UIKit

struct Weather {
    // MARK: Use cases
    
    
    struct Something {
        struct Request {
            var city: String
        }
        
        struct Response {
            //to the presenter
            var city: String
            var weather: [WeatherData]
        }
        
        struct ViewModel {
          //from presenter to viewControler
            var responseToController : [WeatherData]
        }
    }
}
