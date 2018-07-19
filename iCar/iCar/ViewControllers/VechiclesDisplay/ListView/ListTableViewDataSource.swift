//
//  ListTableViewDataSource.swift
//  iCar
//
//  Created by Amr ELghadban on 7/19/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class ListTableViewDataSource: NSObject, UITableViewDataSource {

    // MARK: - Properties

    var viewModel: ListViewModel?
    var table: UITableView?

    // MARK: Constarctor

    init(viewModel: ListViewModel, table: UITableView) {
        super.init()

        self.viewModel = viewModel
        self.viewModel?.delegate = self
        self.table = table
    }

    // MARK: - Table View

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSourceObjects = viewModel?.dataSourceObjects else {
            return 0
        }

        return dataSourceObjects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VehiclesTableViewCell.Identity, for: indexPath) as? VehiclesTableViewCell else {
            return UITableViewCell()
        }

        guard let dataSourceObjects = viewModel?.dataSourceObjects else {
            return UITableViewCell()
        }
        let object = dataSourceObjects[indexPath.row]
        cell.bindData(object: object)

        return cell
    }
}

// MARK: - ViewModelDelegate

extension ListTableViewDataSource: ListViewModelDelegate {
    func successRetrivingResult() {
        self.table?.reloadData()
    }

    func failureRetrivingResult(error msg: String) {
        self.table?.reloadData()
    }
}
