//
//  SearchViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import CoreLocation
import UIKit

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

    private let searchAPI: GourmetSearchAPIProtocol = MockGourmetSearchAPI()
    private let location = Location()
    private let loadingView = LoadingView()

    override func viewDidLoad() {
        super.viewDidLoad()
        location.startUpdatingLocation()
        loadingView.setDescription(discription: "検索中…")
        setupNavigationItem()
    }

    private func setupNavigationItem() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    private func search(genre: GourmetGenre) {
        appearLoadingView()

        searchAPI.searchRestaurant(
            latitude: location.latitude,
            longitude: location.longitude,
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
        vc.setShops(searchResult.shop)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
