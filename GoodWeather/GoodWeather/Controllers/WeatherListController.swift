//
//  WeatherListController.swift
//  GoodWeather
//
//  Created by Nitin A on 25/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class WeatherListController: UITableViewController, AddWeatherDelegate, SettingsDelegate {
    
    // MARK: - Variables
    private var weatherListViewModel = WeatherListViewModel()
    private var dataSource: TableDataSource<WeatherListTableCell, WeatherViewModel>?
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    private func initialSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableDataSource(identifier: "WeatherListTableCell",
                                          items: self.weatherListViewModel.weatherViewModels,
                                          configure:
            { (cell, data) in
                cell.configure(viewModel: data)
        })
        self.tableView.dataSource = self.dataSource
    }
    
    @IBAction func addWeatherCityHandle(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddWeatherCityController") as! AddWeatherCityController
        controller.delegate = self
        let navigation = UINavigationController(rootViewController: controller)
        self.present(navigation, animated: true, completion: nil)
    }
    
    @IBAction func settingsHandle(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SettingsController") as! SettingsController
        controller.delegate = self
        let navigation = UINavigationController(rootViewController: controller)
        self.present(navigation, animated: true, completion: nil)
    }
    
    func didWeatherFetched(weatherViewModel: WeatherViewModel) {
        self.weatherListViewModel.addWeatherViewModel(weatherViewModel)
        self.dataSource?.updateItems(self.weatherListViewModel.weatherViewModels)
        self.tableView.reloadData()
    }
    
    func didSettingsDone(viewModel: SettingsViewModel) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.weatherListViewModel.modelAt(index: indexPath.row)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailsController") as! WeatherDetailsController
        controller.weatherViewModel = viewModel
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
