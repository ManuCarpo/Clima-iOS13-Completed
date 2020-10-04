//
//  WeatherModel.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // Modo alternativo di tradurre un tipo "Double" in un tipo "String". La tipologia ' {return} ' usata nelle proprietà(variabili/costanti) è uguale a fare ' = '.
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    
    // Switcho il conditionName a seconda del conditionId al fine di ritornare l'immagine che desidero, a seconda del meteo ottenuto.
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
