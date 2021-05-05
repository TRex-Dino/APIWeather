//
//  ViewController.swift
//  APIWeather
//
//  Created by Dmitry on 30.04.2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    
    @IBOutlet var searchTextField: UITextField!
    
    private var currentWeather: WeatherData?
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
}
extension WeatherViewController {
    
    private func fetchDataWeather(urlString: String) {
        WeatherManager.shared.fetchData(from: urlString) { weather in
            self.currentWeather = weather
            
            self.cityLabel.text = self.currentWeather?.name
            self.temperatureLabel.text = String(self.currentWeather?.main?.temp ?? 0)
            self.weatherLabel.text = self.currentWeather?.weather?.first?.description
        }
    }
    
}

extension WeatherViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            if city.contains(" ") {
                let newCity = city.components(separatedBy: " ").joined(separator: "+")
                fetchDataWeather(urlString: newCity)
            } else {
                fetchDataWeather(urlString: city)
            }
        }
        searchTextField.text = ""
    }
}
