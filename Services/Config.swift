//
//  Config.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 12/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import Foundation

struct API {
    static let key = Key.weatherApiKey.rawValue
    static let baseURL = "https://samples.openweathermap.org/data/2.5/"
}

enum Key: String {
    //create an  ApiKey from https://samples.openweathermap.org/
    case weatherApiKey = "662758b0d9fcd501fe2186041341037d"
}
