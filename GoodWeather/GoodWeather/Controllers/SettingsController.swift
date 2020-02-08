//
//  SettingsController.swift
//  GoodWeather
//
//  Created by Nitin A on 28/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func didSettingsDone(viewModel: SettingsViewModel)
}

class SettingsController: UITableViewController {

    // MARK: - Variables
    private var settingsViewModel = SettingsViewModel()
    private var dataSource: TableDataSource<UITableViewCell, Unit>?
    var delegate: SettingsDelegate?
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.dataSource = TableDataSource(identifier: "SettingsTableCell",
                                          items: self.settingsViewModel.units,
                                          configure:
            { (cell, data) in
                cell.textLabel?.text = data.displayName
                if data == self.settingsViewModel.selectedUnit {
                    cell.accessoryType = .checkmark
                }
        })
        self.tableView.dataSource = self.dataSource
    }
    
    @IBAction func handleDone(_ sender: UIBarButtonItem) {
        if let delegate = self.delegate {
            delegate.didSettingsDone(viewModel: self.settingsViewModel)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // first uncheck all the visible cells
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            self.settingsViewModel.selectedUnit = Unit.allCases[indexPath.item]
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
