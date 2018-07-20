//
//  VehiclesListDisplayViewController.swift
//  iCar
//
//  Created by Amr ELghadban on 7/18/18.
//  Copyright © 2018 ADKA. All rights reserved.
//

import UIKit

class ListDisplayViewController: BaseViewController {

    // MARK: - IBOutlet

    @IBOutlet var tableView: UITableView!

    // MARK: - Properties

    private var listTableViewDataSource: ListTableViewDataSource!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = ListViewModel(dataProvider: DataProvider.share)
        listTableViewDataSource = ListTableViewDataSource(viewModel: viewModel, table: tableView)
        tableView.dataSource = listTableViewDataSource
        listTableViewDataSource.viewModel?.fetchData()
    }
}
    // MARK: - NavigationRouterProtocol
extension ListDisplayViewController: NavigationRouterProtocol {
    static func instantiateFromStoryboard() -> BaseViewController {
        let storyboard = Storyboards.Main.instance
        let identity = self.Identity
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identity) as? ListDisplayViewController else {
//            assertionFailure("can't instantiate object form storyboard for ListDisplayViewController")
            return self.init()
        }
        return viewController
    }
}
