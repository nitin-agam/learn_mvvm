//
//  WeatherListTableCell.swift
//  GoodWeather
//
//  Created by Nitin A on 28/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class WeatherListTableCell: UITableViewCell {

    func configure(viewModel: WeatherViewModel) {
        textLabel?.text = viewModel.name.value
        detailTextLabel?.text = viewModel.temperature.value
    }
}
