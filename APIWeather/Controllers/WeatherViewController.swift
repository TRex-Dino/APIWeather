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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        fetchWeather()
    }
    
}
extension WeatherViewController {
    

    private func fetchWeather() {
        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=737d31778476ecdaa57002f152c41089&units=metric"
        
        let urlString = "\(weatherURL)&q=\(searchTextField.text ?? "")"
        performRequest(urlString: urlString)
    }
    
    private func performRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return }
            DispatchQueue.main.async {
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    self.cityLabel.text = weather.name ?? "Not correct city"
                    let tempString = String(format: "%.1f", weather.main?.temp ?? 0)
                    self.temperatureLabel.text = tempString
                    self.weatherLabel.text = weather.weather?.first?.description ?? "0"
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            
        }.resume()
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
        
    }
    
    func configuration(with weather: WeatherData) {
    }
    
    
}
