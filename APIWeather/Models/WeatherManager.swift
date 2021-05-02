//
//  File.swift
//  APIWeather
//
//  Created by Dmitry on 01.05.2021.
//

import Foundation

struct WeatherManager {
    static let shared = WeatherManager()
    private let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=737d31778476ecdaa57002f152c41089&units=metric"

//    func fetchWeather(cityName: String) {
//        let urlString = "\(weatherURL)&q=\(cityName)"
//        performRequest(urlString: urlString)
//    }
    func fetchData<T: Decodable>(cityName: String, type: T.Type, complition: @escaping(T)->Void) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(type, from: data)
                complition(weather)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private init() {}
//    func performRequest(urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {
//                print(error?.localizedDescription ?? "No error description")
//                return }
//            do {
//                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
//                print(weather)
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
    
}
