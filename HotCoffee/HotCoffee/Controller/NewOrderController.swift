//
//  NewOrderController.swift
//  HotCoffee
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

protocol AddOrderProtocol {
    func didAddedOrder(order: Order)
}

class NewOrderController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coffeeSizeSegmentControl: UISegmentedControl!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var addOrderViewModel = AddOrderViewModel()
    var delegate: AddOrderProtocol?
    private var selectedTypeIndex = -1
    private var selectedSizeIndex = 0
    
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        view.backgroundColor = .white
    }

    @IBAction func saveOrderHandle(_ sender: Any) {
        validateFields()
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        self.selectedSizeIndex = sender.selectedSegmentIndex
    }
    
    private func validateFields() {
        
        guard let name = self.nameTextField.text, name.isEmpty == false else {
            return
        }
        
        guard let email = self.emailTextField.text, email.isEmpty == false else {
            return
        }
        
        if selectedTypeIndex < 0 { return }
        
        guard let selectedCoffeeSizeTitle = self.coffeeSizeSegmentControl.titleForSegment(at: selectedSizeIndex) else {
            return
        }
        
        self.addOrderViewModel.name = name
        self.addOrderViewModel.email = email
        self.addOrderViewModel.size = selectedCoffeeSizeTitle
        self.addOrderViewModel.type = self.addOrderViewModel.types[selectedTypeIndex]
        addOrder()
    }
    
    private func addOrder() {
        WebService().load(resource: Order.createResource(viewModel: self.addOrderViewModel)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    delegate.didAddedOrder(order: order)
                    self.navigationController?.popViewController(animated: true)
                }
                
            case .failure(let error):
                Toaster.shared.showToast(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addOrderViewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableCell", for: indexPath)
        cell.textLabel?.text = addOrderViewModel.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedTypeIndex = indexPath.row
//        self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
//    }
}
