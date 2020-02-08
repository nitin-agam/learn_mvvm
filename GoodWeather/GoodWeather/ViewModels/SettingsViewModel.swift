//
//  SettingsViewModel.swift
//  GoodWeather
//
//  Created by Nitin A on 28/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

enum Unit: String, CaseIterable {
    
    case celsius = "metric"
    case fahrenheit = "imperial"
    
    var displayName: String {
        get {
            switch self {
            case .celsius: return "Celsius"
            case .fahrenheit: return "Fahrenheit"
            }
        }
    }
}

struct SettingsViewModel {
    
    let units = Unit.allCases
    
    private let defaultUnit = Unit.fahrenheit
    
    var selectedUnit: Unit {
        get {
            let userDefault = UserDefaults.standard
            if let value = userDefault.value(forKey: "unit") as? String {
                return Unit(rawValue: value) ?? defaultUnit
            }
            return defaultUnit
        }
        
        set {
            let userDefault = UserDefaults.standard
            userDefault.set(newValue.rawValue, forKey: "unit")
        }
    }
}
