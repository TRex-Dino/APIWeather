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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherManager.shared.fetchData(cityName: "Moscow", type: WeatherData.self) { (<#Decodable#>) in
            <#code#>
        }
    }

    @IBAction func searchPressed(_ sender: UIButton) {
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
//        guard let city = searchTextField.text else { return }
        
    }
    
    func configuration(with weather: WeatherData) {
//        cityLabel.text = weather.name
    }
    
    
}


