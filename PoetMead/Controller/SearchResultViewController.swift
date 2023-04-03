//
//  SearchResultViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/28.
//

import UIKit

class SearchResultViewController: UIViewController {
    private var shops: [Shop] = []
    @IBOutlet var searchResultTable: UITableView!

    func setShops(_ shops: [Shop]) {
        self.shops = shops
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func setupTableView() {
        searchResultTable.dataSource = self
        searchResultTable.register(UINib(nibName: SearchResultCell.className, bundle: nil), forCellReuseIdentifier: SearchResultCell.cellReuseIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return shops.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.cellReuseIdentifier, for: indexPath) as! SearchResultCell
        cell.setContent(shop: shops[indexPath.row])

        return cell
    }
}
