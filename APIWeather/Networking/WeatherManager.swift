//
//  File.swift
//  APIWeather
//
//  Created by Dmitry on 01.05.2021.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=737d31778476ecdaa57002f152c41089&units=metric"

    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return }
            do {
                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                print(weather)
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
//    func fetchData(cityName: String, completion: @escaping(WeatherModel)->()) {
//        let urlString = "\(weatherURL)&q=\(cityName)"
//        guard let url = URL(string: urlString) else { return }
//        
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            guard let data = data else { return }
//            
//        }.resume()
//    }
    
}
