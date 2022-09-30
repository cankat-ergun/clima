

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var conditionName: String {
        var weatherCondition: String
        switch conditionId {
        case 200...232:
            weatherCondition = "cloud.bolt" //Thunderstorm Icon
        case 300...321:
            weatherCondition = "cloud.drizzle"
        case 500...531:
            weatherCondition = "cloud.heavyrain"
        case 600...622:
            weatherCondition = "cloud.snow"
        case 800:
            weatherCondition = "sun.max"
        case 801...804:
            weatherCondition = "cloud"
        default:
            weatherCondition = "sun.haze.fill"
        }
        return weatherCondition
    }
    
    var formattedTemp: String {
        return String(format: "%.1f", temperature)
    }
    

    
}


