//
//  ViewController.swift
//  Clima
//
//  Griffin Reding
//
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var highLow: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Hey dumbass, city and state."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let desiredLoc = searchTextField.text {
        weatherManager.fetchWeather(desiredLoc)
        }
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
            let lowString = String(format: "%.2f", weather.tempLow)
            let highString = String(format: "%.2f", weather.tempHigh)
            self.highLow.text = "High: \(highString) Low: \(lowString)"
            print(weather.temperature)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

