//
//  Presenter.swift
//  VK_weather
//
//  Created by Yersin Kazybekov on 20.03.2024.
//

import UIKit
import CoreLocation



class Presenter {
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation = CLLocation.init(latitude: 0, longitude: 0)
    
    var weatherArray:[Weather] = []
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let dateFormatter = DateFormatter()
    var currentDate = Date()
    
    init() {
        getLocation()
        Task{
            await fetchData()
            semaphore.signal()
        }
        semaphore.wait()
        filterArray()
        setTime()
    }
    func setTime(){
        dateFormatter.dateFormat = "EEEE | MMM d"
        for i in 0...weatherArray.count-1 {
            weatherArray[i].date = dateFormatter.string(from: currentDate)
            if let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) {
                    currentDate = nextDate
            }
        }
    }
    func filterArray(){
        var tempArray:[Weather] = []
        for (index, value) in weatherArray.enumerated() {
                if index % 3 == 0 {
                    tempArray.append(value)
                }
        }
        weatherArray = tempArray
    }
    
    func fetchData() async {
        guard let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat="+String(currentLocation.coordinate.latitude)+"&lon="+String(currentLocation.coordinate.longitude)+"&appid=89aaf36b797a357bf2ac72d73ac37fa0&units=metric") else{
            return}
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            parseData(jsonData: data)
        }catch{
            print("Error downloading data")
        }
        
    }
    
    func parseData(jsonData:Data){
        do {
            let decoder = JSONDecoder()
            let weatherData = try decoder.decode(WeatherData.self, from: jsonData)
            
            let city = weatherData.city.name
        
            for weatherInfo in weatherData.list {
                let temp = weatherInfo.main.temp
                let humidity = weatherInfo.main.humidity
                let minTemp = weatherInfo.main.temp_min
                let maxTemp = weatherInfo.main.temp_max
                let feelsLike = weatherInfo.main.feels_like
                let weatherId = weatherInfo.weather.first?.id ?? 800
                let windSpeed = weatherInfo.wind.speed
                let pressure = weatherInfo.main.pressure
        
                let model = Weather(temp: temp, humidity: Double(humidity), minTemp: minTemp, maxTemp: maxTemp, feelsLike: feelsLike, imageName: imageNameById(id: weatherId), windSpeed: windSpeed, date: " ",city: city,pressure: pressure)
                
                weatherArray.append(model)
                
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }
    
    func imageNameById(id:Int)->String{
        
        if(id<300){
            return "cloud.bolt.rain.fill"
        }
        if(id<500){
            return "cloud.rain"
        }
        if(id<600){
            return "cloud.snow"
        }
        if(id<800){
            return "smoke"
        }
        if(id==800){
            return "sun.max"
        }
        if(id<1000){
            return "cloud.sun"
        }
        
        return "sun.max"
    }
    
    func getLocation(){
        locationManager.requestWhenInUseAuthorization()
        switch locationManager.authorizationStatus {
        case .restricted, .denied:
            locationManager.requestLocation()
            getLocation()
        default:
            currentLocation = locationManager.location ?? CLLocation.init(latitude: 0, longitude: 0)
        }
    }
}

struct Weather{
    let temp:Double
    let humidity:Double
    let minTemp:Double
    let maxTemp:Double
    let feelsLike:Double
    let imageName:String
    let windSpeed:Double
    var date:String
    let city:String
    let pressure:Int
}

struct WeatherData: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherInfo]
    let city: CityInfo
}

struct WeatherInfo: Codable {
    let dt: TimeInterval
    let main: MainInfo
    let weather: [WeatherDetail]
    let wind: WindInfo
    let dt_txt: String
}

struct MainInfo: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
    let feels_like: Double
    
}

struct WeatherDetail: Codable {
    let id: Int
    let main: String
    let description: String
}

struct WindInfo: Codable {
    let speed: Double
}

struct CityInfo: Codable {
    let name: String
}
