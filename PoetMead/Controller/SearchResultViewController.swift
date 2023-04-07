//
//  SearchResultViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/28.
//

import MapKit
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
        setupNavigationItem()
    }

    private func setupNavigationItem() {
        navigationItem.title = "検索結果"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func setupTableView() {
        searchResultTable.delegate = self
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

    // セルタップ時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transitionToDetailView(shop: shops[indexPath.row])
    }

    private func transitionToDetailView(shop: Shop) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        vc.setContent(shop: shop)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
