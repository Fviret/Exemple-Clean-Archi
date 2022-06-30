//
//  WeatherWorker.swift
//  WeatherTest


import UIKit

struct WeatherWorker {
    func doSomeWork(url: String, completion: @escaping ([WeatherData]?, Error?) -> ()) {
        APIWorker().callAPI(url: url, completion: completion)
    }
}
