//
//  WeatherModel.swift
//  Clima
//
//  Created by Tahiru nasuru on 6/16/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityname: String
    let conditionId: Int
    let description: String
    let temp: Double
    
    
    var getCity: String{
        return cityname;
    }
    
    var getDescription: String{
        return description;
    }
    
    var getTemp: String{
        return String(format: "%.1f", temp)
    }
    
    var getWeatherCondition: String {
        switch conditionId {
        case 200...300:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.rain"
        case 700...700:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...900:
            return "cloud.bold"
        default:
            return "cloud"
        }
    }
    
    
}
