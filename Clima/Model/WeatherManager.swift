

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
        
    }
    
struct WeatherManager {
    
    let apıKey = "6cb3ab48ed68b0ca41ba8228ea3b7f56"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=6cb3ab48ed68b0ca41ba8228ea3b7f56&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchCityWeather(cityName: String) {
        let cityURLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: cityURLString)
    }
    
    
    func fetchLocationWeather(lat latitude: CLLocationDegrees , lon longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            let task = session.dataTask(with: url) {(data, response, error) in // Completion Handler
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = parseJSON(safeData) { // if it does not work try adding self. in front of
                        delegate?.didUpdateWeather(self, weather: weather) // There was a self. in front of the delegate but did not crash the app when i remove it
                    }
                }
            }
                //4. Start the task
                task.resume() // It's called resume but ıt's actually starting the task
                
            }
        }
  
        
        func parseJSON(_ weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do { // do hast
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData) // to make it not an object but a data type put .self notation after it
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
    
    

