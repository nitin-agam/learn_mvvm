//
//  TableDataSource.swift
//  GoodWeather
//
//  Created by Nitin A on 05/02/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import Foundation
import UIKit

class TableDataSource<CellType, DataModel>: NSObject, UITableViewDataSource where CellType: UITableViewCell {
    
    let cellIdentifier: String
    var items: [DataModel]
    let configureCell: (CellType, DataModel) -> ()
    
    init(identifier: String, items: [DataModel], configure: @escaping (CellType, DataModel) -> ()) {
        self.cellIdentifier = identifier
        self.items = items
        self.configureCell = configure
    }
    
    func updateItems(_ items: [DataModel]) {
        self.items = items
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CellType else {
            fatalError("Cell with identifier \(cellIdentifier) not found...")
        }
        self.configureCell(cell, self.items[indexPath.row])
        return cell
    }
}
