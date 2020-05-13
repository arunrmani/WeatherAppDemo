//
//  WeatherData.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 12/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import Foundation

class WeatherDataList: NSObject {
    var list : [WeatherData] = []
    var cityName : String = ""
     init(dic : [String:Any]) {
        if let city = dic["city"] as? [String:Any]{
            if let name = city["name"]{
                self.cityName = name as? String ?? ""
            }
        }
        guard let array:[[String: Any]] = dic["list"] as? [[String: Any]]  else {
            return
        }
        self.list = array.compactMap{ (dic) in
            return WeatherData(data: dic)
        }
    }
}

class WeatherData: NSObject {
    var cityName : String = ""
    var tempMin : Double = 0.0
    var tempMax : Double = 0.0
    var windSpeed : Double = 0.0
    var weatherDescription : String = ""
    var date  : Double = 0.0
    init(data : [String:Any]) {
        self.cityName = data["name"] as? String ?? ""
        if let mainTemp = data["main"] as? [String:Any]{
            if let temp_min = mainTemp["temp_min"]{
                self.tempMin = temp_min as? Double ?? 0.0
            }
            if let temp_max = mainTemp["temp_max"]{
                self.tempMax = temp_max as? Double ?? 0.0
            }
        }
        if let wind = data["wind"] as? [String:Any]{
            if let speed = wind["speed"]{
                self.windSpeed = speed as? Double ?? 0.0
            }
        }
        if let weather = data["weather"] as? [[String:Any]]{
            if weather.count > 0{
                if let description = weather[0]["description"]{
                    self.weatherDescription = description as? String ?? ""
                }
            }
        }
        self.date = data["dt"] as? Double ?? 0.0

    }

}
