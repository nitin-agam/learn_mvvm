//
//  OrderViewModel.swift
//  HotCoffee
//
//  Created by Nitin A on 23/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

struct OrderListViewModel {
    
    var ordersViewModel: [OrderViewModel]
    
    init() {
        self.ordersViewModel = []
    }

    func orderViewModel(at index: Int) -> OrderViewModel {
        return self.ordersViewModel[index]
    }
}

struct OrderViewModel {
    
    let order: Order
    
    var name: String {
        return self.order.name
    }
    
    var email: String {
        return self.order.email
    }
    
    var type: String {
        return self.order.type.rawValue.capitalized
    }

    var size: String {
        return self.order.size.rawValue.capitalized
    }
}
