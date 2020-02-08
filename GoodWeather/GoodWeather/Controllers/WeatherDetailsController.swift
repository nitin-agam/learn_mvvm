//
//  WeatherDetailsController.swift
//  GoodWeather
//
//  Created by Nitin A on 30/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class WeatherDetailsController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    var weatherViewModel: WeatherViewModel?
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setupBindings()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
    }
    
    private func setupBindings() {
        if let viewModel = self.weatherViewModel {
            // view model to view binding
            viewModel.name.bind { self.cityLabel.text = $0 }
            viewModel.temperature.bind { self.tempLabel.text = $0 }
            viewModel.temperatureMin.bind { self.minTempLabel.text = $0 }
            viewModel.temperatureMax.bind { self.maxTempLabel.text = $0 }
            
            // This is just for testing to test the binding from ViewModel to View.
            /*
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                viewModel.name.value = "Delhi"
            }
 */
        }
    }
}
