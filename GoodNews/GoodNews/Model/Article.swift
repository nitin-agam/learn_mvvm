//
//  Article.swift
//  GoodNews
//
//  Created by Nitin A on 22/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
