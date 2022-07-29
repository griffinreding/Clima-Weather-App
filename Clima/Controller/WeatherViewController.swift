//
//  ViewController.swift
//  Clima
//
//  Griffin Reding
//
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        weatherManager.fetchWeather(cityName: desiredLoc)
        }
    }
    
}

