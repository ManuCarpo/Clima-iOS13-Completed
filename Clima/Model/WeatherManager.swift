//
//  WeatherManager.swift
//  Clima
//
//  Created by Angela Yu on 03/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

// La struttura è separata dal WeatherViewController class, quindi nel momento in cui abbiamo bisogno di implementare questa struttura in una nuova classe, basta creare una riga di codice nella nuova classe che la renda il delegato: ' NomeClasse.delegate = self '
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a8d8b8fa171a8b17fc9e57249e8c9d85&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        
        // Triggher della richiesta di data al sito.
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        
        // Triggher della richiesta di data al sito.
        performRequest(with: urlString)
    }
    
    // Il performRequest è un metodo per fare la richiesta di data ad un sito. Si sviluppa nella maniera sottostante.
    func performRequest(with urlString: String) {
        
        //1.Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession (è ciò che permette di fare networking)
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            //4. Start the task
            task.resume()
        }
    }
    
    // Metodo che decodifica la data ottenuta da un oggetto di tipo JSON.
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}


