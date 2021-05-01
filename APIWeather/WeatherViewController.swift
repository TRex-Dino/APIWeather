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
    
    @IBOutlet var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    private var weather = [WeatherData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        fetchWeather()
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
        guard let city = searchTextField.text else { return }
        
        weatherManager.fetchWeather(cityName: city)
    }
    
    func configuration(with weather: WeatherData) {
        cityLabel.text = weather.name
    }
    
    
}
extension WeatherViewController {
    

    func fetchWeather() {
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=737d31778476ecdaa57002f152c41089&units=metric"
        
        let urlString = "\(weatherURL)&q=\(searchTextField.text ?? "")"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return }
            DispatchQueue.main.async {
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    self.cityLabel.text = weather.name ?? "No"
                    self.temperatureLabel.text = "\(weather.main?.temp ?? 0)"
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
    }
}

