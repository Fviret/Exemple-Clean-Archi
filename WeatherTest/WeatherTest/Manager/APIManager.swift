//
//  APIManager.swift
//  Test
//

import Foundation

protocol APIWorkerProtocol {
    func callAPI(url: String, completion: @escaping ([WeatherData], Error?) -> ())
}

struct APIWorker: APIWorkerProtocol {
    func callAPI(url: String, completion: @escaping ([WeatherData], Error?) -> ()) {
        guard let url = URL(string: url) else {
            return completion([], URLError(.badURL))
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let entity = WeatherData.decode(from: data) {
                DispatchQueue.main.async {
                    completion([entity], nil)
                }
            }else{
                    DispatchQueue.main.async {
                        completion([], error)
                    }
                }
            }
            task.resume()
        }
}

extension Encodable {
    var data: Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            print(error)
            return nil
        }
    }
}

extension Decodable {
    static func decode(from data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}
