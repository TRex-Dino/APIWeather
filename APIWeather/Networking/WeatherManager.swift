//
//  File.swift
//  APIWeather
//
//  Created by Dmitry on 01.05.2021.
//

import Foundation

class WeatherManager {
    static let shared = WeatherManager()
    
    private init() {}
    
    func fetchData(from cityName: String, with complition: @escaping(WeatherData)->Void) {
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=737d31778476ecdaa57002f152c41089&units=metric"
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                DispatchQueue.main.async{
                    complition(weatherData)
                    
                }
                
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
