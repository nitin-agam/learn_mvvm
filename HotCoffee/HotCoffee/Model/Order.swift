//
//  Order.swift
//  HotCoffee
//
//  Created by Nitin A on 23/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

enum CoffeeType: String, Codable, CaseIterable {
    case cappuccino
    case latte
    case espressino
    case cortado
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = CoffeeType(rawValue: label) ?? .latte
    }
}

enum CoffeeSize: String, Codable, CaseIterable {
    case small
    case medium
    case large
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = CoffeeSize(rawValue: label) ?? .small
    }
}

struct Order: Codable {
    let name: String
    let email: String
    let type: CoffeeType
    let size: CoffeeSize
}

extension Order {
    
    init?(addOrderViewModel viewModel: AddOrderViewModel) {
        guard let name = viewModel.name,
            let email = viewModel.email,
            let type = CoffeeType(rawValue: viewModel.type?.lowercased() ?? ""),
            let size = CoffeeSize(rawValue: viewModel.size?.lowercased() ?? "") else {
                return nil
        }
        
        self.name = name
        self.email = email
        self.type = type
        self.size = size
    }
}

extension Order {
    
    static var all: Resource<[Order]> {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
                fatalError("url is not correct")
        }
        return Resource<[Order]>(url: url)
    }
    
    static func createResource(viewModel: AddOrderViewModel) -> Resource<Order?> {
        guard let order = Order(addOrderViewModel: viewModel),
            let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders"),
            let data = try? JSONEncoder().encode(order) else {
                fatalError("url is not correct")
        }
        return Resource<Order?>(url: url, httpMethod: .post, body: data)
    }
}
