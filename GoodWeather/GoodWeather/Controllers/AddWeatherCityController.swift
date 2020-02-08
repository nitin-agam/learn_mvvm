//
//  AddWeatherCityController.swift
//  GoodWeather
//
//  Created by Nitin A on 25/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

protocol AddWeatherDelegate {
    func didWeatherFetched(weatherViewModel: WeatherViewModel)
}

class AddWeatherCityController: UIViewController {

    // MARK: - Variables
    @IBOutlet weak var cityTextField: BindingTextField! {
        didSet {
            cityTextField.bind {
                self.addCityViewModel.city = $0
            }
        }
    }
    
    @IBOutlet weak var stateTextField: BindingTextField! {
        didSet {
            stateTextField.bind { self.addCityViewModel.state = $0 }
        }
    }
    
    @IBOutlet weak var zipcodeTextField: BindingTextField! {
        didSet {
            zipcodeTextField.bind { self.addCityViewModel.zipcode = $0 }
        }
    }
    
    var delegate: AddWeatherDelegate?
    private var addCityViewModel = AddCityViewModel()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.cityTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Methods
    private func initialSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = "Weather City"
    }
    
    @IBAction func handleClose() {
        self.cityTextField.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSave() {
        
        guard let cityName = self.cityTextField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        let urlString = URLString.kBase + "weather?q=\(cityName)&appid=\(URLString.kWeatherAPIKey)"
        if let weatherUrl = URL(string: urlString) {
            
            let resource = Resource<WeatherViewModel>(url: weatherUrl) { data in
                let weatherViewModel = try? JSONDecoder().decode(WeatherViewModel.self, from: data)
                return weatherViewModel
            }
            
            NetworkManager().load(resource: resource) { [weak self] (result) in
                if let weather = result, let delegate = self?.delegate {
                    delegate.didWeatherFetched(weatherViewModel: weather)
                    self?.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}
