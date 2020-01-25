//
//  HeadlinesController.swift
//  GoodNews
//
//  Created by Nitin A on 16/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class HeadlinesController: UITableViewController {

    private var articleListViewModel: ArticleListViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        fetchData()
    }
    
    private func initialSetup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func fetchData() {
        DataManager.shared.fetchArticle { (array) in
            if let articleArray = array {
                self.articleListViewModel = ArticleListViewModel(articles: articleArray)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeadlineTableCell", for: indexPath) as! HeadlineTableCell
        let articleViewModel = self.articleListViewModel.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleViewModel.title
        cell.descriptionLabel.text = articleViewModel.description
        return cell
    }
}
