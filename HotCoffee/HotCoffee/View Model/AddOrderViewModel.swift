//
//  AddOrderViewModel.swift
//  HotCoffee
//
//  Created by Nitin A on 23/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

struct AddOrderViewModel {
    
    var name: String?
    var email: String?
    var size: String?
    var type: String?
    
    var types: [String] {
        return CoffeeType.allCases.map({$0.rawValue.capitalized})
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map({$0.rawValue.capitalized})
    }
}
