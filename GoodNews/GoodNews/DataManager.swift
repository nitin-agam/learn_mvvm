//
//  DataManager.swift
//  GoodNews
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    func fetchArticle(completion: @escaping (([Article]?) -> Void)) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=in&apiKey=1e79d5f171d746a6b37be37a5909029d"
        NetworkManager.shared.sendRequest(urlString: urlString,
                                          method: .kGET,
                                          parameters: nil)
        { (data, error) in
            
            if error != nil { completion(nil) }
            
            if let data = data {
                let articles = try? JSONDecoder().decode(ArticleList.self, from: data).articles
                print("count: \(String(describing: articles?.count))")
                completion(articles)
            }
        }
    }
}
