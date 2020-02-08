//
//  NetworkManager.swift
//  GoodWeather
//
//  Created by Nitin A on 25/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

struct Resource<T> {
    let url: URL
    var parse: (Data) -> T?
}

final class NetworkManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
