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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            searchTextField.text = ""
            return true
        } else {
            textField.placeholder = "Hey dumbass, city and state."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) -> String {
        let desiredLoc = searchTextField.text
        searchTextField.text = ""
        return desiredLoc ?? ""
    }
    
}

