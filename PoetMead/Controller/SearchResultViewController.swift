//
//  SearchResultViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/28.
//

import MapKit
import UIKit

/// 検索結果画面
class SearchResultViewController: UIViewController {
    @IBOutlet var searchResultTable: UITableView!
    private var shops: [Shop] = []
    private var hitCount: Int = 0
    private var srcLng: Double?
    private var srcLat: Double?

    /// 一覧に表示する店舗情報と検索結果数を設定
    func setShops(_ shops: [Shop], _ hitCount: Int) {
        self.shops = shops
        self.hitCount = hitCount
    }

    /// 現在地の座標を設定
    func setSrcLocation(_ srcLng: Double, _ srcLat: Double) {
        self.srcLng = srcLng
        self.srcLat = srcLat
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationItem()
    }

    private func setupNavigationItem() {
        // ナビゲーションバーのtitleに検索結果数を表示
        navigationItem.title = "検索結果: \(hitCount)件"

        // 店舗詳細画面のナビゲーションバーの設定
        // 戻るボタンの文字を非表示にする
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        guard let srcLat else {
            print("srcLat is nil")
            return
        }
        guard let srcLng else {
            print("srcLng is nil")
            return
        }
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailViewController
        vc.setSrcLocation(srcLng, srcLat)
        vc.setContent(shop: shop)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let indexPath = searchResultTable.indexPathForSelectedRow {
            searchResultTable.deselectRow(at: indexPath, animated: true)
        }
    }
}
