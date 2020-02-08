//
//  OrderListController.swift
//  HotCoffee
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class OrderListController: UITableViewController, AddOrderProtocol {

    // MARK: - Variables
    var orderListViewModel = OrderListViewModel()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrders()
    }
    
    
    // MARK: - Private Methods
    private func fetchOrders() {
        WebService().load(resource: Order.all) { [weak self] (result) in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func didAddedOrder(order: Order) {
        let orderViewModel = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderViewModel)
        let indexPath = IndexPath(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func addOrderHandle(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NewOrderController") as! NewOrderController
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableCell", for: indexPath)
        let order = self.orderListViewModel.orderViewModel(at: indexPath.row)
        cell.textLabel?.text = order.type
        cell.detailTextLabel?.text = order.size
        return cell
    }
}
