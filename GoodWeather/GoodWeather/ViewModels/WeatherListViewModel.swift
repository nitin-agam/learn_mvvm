//
//  WeatherListViewModel.swift
//  GoodWeather
//
//  Created by Nitin A on 25/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    
    private(set) var weatherViewModels: [WeatherViewModel] = []
    
    func addWeatherViewModel(_ model: WeatherViewModel) {
        self.weatherViewModels.append(model)
    }
    
    func modelAt(index: Int) -> WeatherViewModel {
        self.weatherViewModels[index]
    }
}

class Dynamic<T>: Decodable where T: Decodable {
    
    typealias Listner = (T) -> ()
    var listner: Listner?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listner: @escaping Listner) {
        self.listner = listner
        self.listner?(self.value)
    }
    
    private enum CodingKeys: CodingKey {
        case value
    }
}

struct WeatherViewModel: Decodable {
    
    let name: Dynamic<String>
    var currentTemperature: TemperatureViewModel
    
    private enum CodingKeys: String, CodingKey {
        case name
        case currentTemperature = "main"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = Dynamic(try container.decode(String.self, forKey: .name))
        self.currentTemperature = try container.decode(TemperatureViewModel.self, forKey: .currentTemperature)
    }
    
    var temperature: Dynamic<String> {
        let userDefault = UserDefaults.standard
        if let value = userDefault.value(forKey: "unit") as? String {
            let defaultUnit = Unit(rawValue: value)
            switch defaultUnit {
            case .celsius: return Dynamic(currentTemperature.temperature.value.toCelsius.formatAsDegree)
            case .fahrenheit: return Dynamic(currentTemperature.temperature.value.toFahrenheit.formatAsDegree)
            case .none: return Dynamic(currentTemperature.temperature.value.formatAsDegree)
            }
        }
        return Dynamic(currentTemperature.temperature.value.formatAsDegree)
    }
    
    var temperatureMin: Dynamic<String> {
        let userDefault = UserDefaults.standard
        if let value = userDefault.value(forKey: "unit") as? String {
            let defaultUnit = Unit(rawValue: value)
            switch defaultUnit {
            case .celsius: return Dynamic(currentTemperature.temperatureMin.value.toCelsius.formatAsDegree)
            case .fahrenheit: return Dynamic(currentTemperature.temperatureMin.value.toFahrenheit.formatAsDegree)
            case .none: return Dynamic(currentTemperature.temperatureMin.value.formatAsDegree)
            }
        }
        return Dynamic(currentTemperature.temperatureMin.value.formatAsDegree)
    }
    
    var temperatureMax: Dynamic<String> {
        let userDefault = UserDefaults.standard
        if let value = userDefault.value(forKey: "unit") as? String {
            let defaultUnit = Unit(rawValue: value)
            switch defaultUnit {
            case .celsius: return Dynamic(currentTemperature.temperatureMax.value.toCelsius.formatAsDegree)
            case .fahrenheit: return Dynamic(currentTemperature.temperatureMax.value.toFahrenheit.formatAsDegree)
            case .none: return Dynamic(currentTemperature.temperatureMax.value.formatAsDegree)
            }
        }
        return Dynamic(currentTemperature.temperatureMax.value.formatAsDegree)
    }
}

struct TemperatureViewModel: Decodable {
    
    var temperature: Dynamic<Double>
    let temperatureMin: Dynamic<Double>
    let temperatureMax: Dynamic<Double>
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case temperatureMin = "temp_min"
        case temperatureMax = "temp_max"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.temperature = Dynamic(try container.decode(Double.self, forKey: .temperature))
        self.temperatureMin = Dynamic(try container.decode(Double.self, forKey: .temperatureMin))
        self.temperatureMax = Dynamic(try container.decode(Double.self, forKey: .temperatureMax))
    }
}
