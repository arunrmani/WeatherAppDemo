//
//  Extention+Double.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 12/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import Foundation

extension Double {
    //kelvin to celsius
    func toCelsius() -> Double {
        return (self - 273.15)
    }
}
