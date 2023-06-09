//
//  SearchViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import CoreLocation
import UIKit

/// 検索条件入力画面
class SearchViewController: UIViewController {
    @IBAction func searchRestaurant(_ sender: UIButton) {
        search(genre: .restaurant)
    }

    @IBAction func searchPub(_ sender: UIButton) {
        search(genre: .pub)
    }

    @IBAction func searchSweets(_ sender: UIButton) {
        search(genre: .sweets)
    }

    @IBOutlet var rangeSlider: RangeSlider!

    private let searchAPI: GourmetSearchAPIProtocol = GourmetSearchAPI()
    private let loadingView = LoadingView()

    var locationManager = CLLocationManager()

    // 初期値は東京都
    var latitude: Double = 35.66934273241242
    var longitude: Double = 139.76927712572368

    override func viewDidLoad() {
        super.viewDidLoad()
        startUpdatingLocation()
        loadingView.setDescription(discription: "検索中…")
        setupNavigationItem()
    }

    /// 検索結果画面で表示するnavigationItemの設定
    private func setupNavigationItem() {
        /// 戻るボタンの文字を非表示にする
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    // この画面ではNavigationBarを非表示
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      navigationController?.isNavigationBarHidden = false
    }

    // この画面ではステータスバーの文字色は黒
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    private func search(genre: GourmetGenre) {
        appearLoadingView()

        searchAPI.searchRestaurant(
            latitude: latitude,
            longitude: longitude,
            range: rangeSlider.range,
            genre: genre,
            completionHandler: { searchResult in
                self.disappearLoadingView()
                switch searchResult {
                case .success(let result):
                    self.transitionToResultView(searchResult: result)
                case .failure:
                    self.appearSearchFailureAlert()
                }
            })
    }

    private func appearLoadingView() {
        view.addSubview(loadingView)
    }

    private func disappearLoadingView() {
        loadingView.removeFromSuperview()
    }

    private func appearSearchFailureAlert() {
        let alert = UIAlertController(title: "検索失敗", message: "検索時にエラーが発生しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }

    private func transitionToResultView(searchResult: SearchResult) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "result") as! SearchResultViewController
        vc.setSrcLocation(longitude, latitude)
        vc.setShops(searchResult.shop, searchResult.resultsAvailable)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
