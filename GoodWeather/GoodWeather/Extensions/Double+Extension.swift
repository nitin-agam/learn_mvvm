//
//  Double+Extension.swift
//  GoodWeather
//
//  Created by Nitin A on 28/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

extension Double {
    
    var formatAsDegree: String {
        String(format: "%.0f°", self)
    }
    
    // convert calvin to fahrenheit
    var toFahrenheit: Double {
        (self - 273.15) * 9/5 + 32
    }
    
    // convert calvin to celcius
    var toCelsius: Double {
        self - 273.15
    }
}
