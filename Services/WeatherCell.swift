//
//  WeatherCell.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 13/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import Foundation
import UIKit


class WeatherCell : UITableViewCell{
    @IBOutlet weak var cityNameLbl : UILabel!
    @IBOutlet weak var weatherDescirptionLbl : UILabel!
    @IBOutlet weak var minTempLbl : UILabel!
    @IBOutlet weak var maxTempLbl : UILabel!
    @IBOutlet weak var windSpeedLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!

    @IBOutlet weak var bgImage : UIImageView!

    override class func awakeFromNib() {
        
    }
    func setCellDataWeather(weatherDataObj:WeatherData){
        cityNameLbl.text = weatherDataObj.cityName
        weatherDescirptionLbl.text = weatherDataObj.weatherDescription
        minTempLbl.text = String(format: "%.2f°C", arguments: [weatherDataObj.tempMin])
        maxTempLbl.text = String(format: "%.2f°C", arguments: [weatherDataObj.tempMax])
        windSpeedLbl.text = String(format: "%.2f", arguments: [weatherDataObj.windSpeed])
        dateLbl.text = weatherDataObj.date.getReadableDate()

        if weatherDataObj.weatherDescription.contains("sunny"){
            bgImage.image = UIImage(named: "Summer")
        }
        if weatherDataObj.weatherDescription.contains("clear"){
            bgImage.image = UIImage(named: "clearSky")
        }
        if weatherDataObj.weatherDescription.contains("mist"){
            bgImage.image = UIImage(named: "mist")
        }
        if weatherDataObj.weatherDescription.contains("snow"){
            bgImage.image = UIImage(named: "mist")
        }
    }
    
    func setCellDataForcast(weatherDataObj:WeatherData){
        cityNameLbl.text = weatherDataObj.cityName
        weatherDescirptionLbl.text = weatherDataObj.weatherDescription
        minTempLbl.text = String(format: "%.2f°C", arguments: [weatherDataObj.tempMin.toCelsius()])
        maxTempLbl.text = String(format: "%.2f°C", arguments: [weatherDataObj.tempMax.toCelsius()])
        windSpeedLbl.text = String(format: "%.2f", arguments: [weatherDataObj.windSpeed])
        dateLbl.text = weatherDataObj.date.getReadableDate()

        if weatherDataObj.weatherDescription.contains("sunny"){
            bgImage.image = UIImage(named: "Summer")
        }
        if weatherDataObj.weatherDescription.contains("clear"){
            bgImage.image = UIImage(named: "clearSky")
        }
        if weatherDataObj.weatherDescription.contains("mist"){
            bgImage.image = UIImage(named: "mist")
        }
        if weatherDataObj.weatherDescription.contains("snow"){
            bgImage.image = UIImage(named: "mist")
        }
    }
}
