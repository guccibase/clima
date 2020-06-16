//
//  WeatherManager.swift
//  Clima
//
//  Created by Tahiru nasuru on 6/13/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
}

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=76da94064479030f3a8ff9bea7117320&q="
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(city:String){
        let urlString = weatherUrl + "\(city)"
        print(urlString)
        performRequest(urlString: urlString)
        
    }
    
    
    
    func  performRequest(urlString: String) {
        //create a URL
        if let url = URL(string: urlString){
            //create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            
            // give the session a task
            let task = urlSession.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let myData = data{
                    if let weather = self.parseJSON(weatherData: myData){
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // start the task
            task.resume()
        }
        
        
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            let conditionId = decodedData.weather[0].id
            let city = decodedData.name
            let description = decodedData.weather[0].description
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(cityname: city, conditionId: conditionId, description: description, temp: temp)
            
            print(weather.getTemp)
            
            return weather
            
        } catch  {
            print("error")
            return nil
        }
    }
    
    
    
    
}
