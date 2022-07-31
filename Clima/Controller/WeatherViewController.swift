//
//  ViewController.swift
//  Clima
//
//  Griffin Reding
//
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var highLow: UILabel!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        locationManager.delegate = self
        
        locationManager.requestLocation()
    }
	@IBAction func locationButton(_ sender: UIButton) {
		locationManager.requestLocation()
	}
	
}
//MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate {
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
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
			self.searchTextField.text = weather.cityName
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
//MARK: - CLLocationManager
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
			locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat, lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
