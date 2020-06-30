//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

//MARK: - ViewController

class WeatherViewController: UIViewController {

    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weatherManager.delegate = self
        searchTextField.delegate = self
    }

    @IBAction func locationButton(_ sender: UIButton) {
               locationManager.requestLocation()
    }
    
}



//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    
    @IBAction func searchPressed(_ sender: Any) {
    
        print(searchTextField.text!)
        searchTextField.endEditing(true)

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchTextField.text!)
        searchTextField.endEditing(true)

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if  let city = searchTextField.text {
        
            weatherManager.fetchWeatherWithCity(city: city)
        }
        
        

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    
    
    func didUpdateWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        
        
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityname
            self.temperatureLabel.text = weather.getTemp
            self.conditionImageView.image = UIImage(systemName: weather.getWeatherCondition)
            self.searchTextField.text = weather.cityname
            
            
        }
    }
    
    func didFailWithError(error: Error)  {
        print(error)
    }
    
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingHeading()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeatherWithLatLon(lat: lat, lon: lon)
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
