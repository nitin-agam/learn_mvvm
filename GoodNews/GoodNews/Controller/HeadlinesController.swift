//
//  HeadlinesController.swift
//  GoodNews
//
//  Created by Nitin A on 16/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class HeadlinesController: UITableViewController {

    // MARK: - Variables
    private var articleListViewModel: ArticleListViewModel!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    
    // MARK: - Private Methods
    private func initialSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchData() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=in&apiKey=1e79d5f171d746a6b37be37a5909029d"
        NetworkManager.shared.sendRequest(urlString: urlString,
                                          method: .kGET,
                                          parameters: nil)
        { (data, error) in
            
            if error != nil { return }
            
            if let data = data {
                if let articles = try? JSONDecoder().decode(ArticleList.self, from: data).articles {
                    self.articleListViewModel = ArticleListViewModel(articles: articles)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return articleListViewModel == nil ? 0 : articleListViewModel.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableCell", for: indexPath) as! HeadlineTableCell
        let articleViewModel = articleListViewModel.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleViewModel.title
        cell.descriptionLabel.text = articleViewModel.description
        return cell
    }
}
