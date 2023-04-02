//
//  SearchViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import CoreLocation
import UIKit

class SearchViewController: UIViewController {
    private let searchAPI = GourmetSearchAPI()
    private let location = Location()

    override func viewDidLoad() {
        super.viewDidLoad()
        location.startUpdatingLocation()
    }

    @IBAction func searchRestaurant(_ sender: UIButton) {
        search(range: rangeSlider.range, genre: .restaurant)
    }

    @IBAction func searchPub(_ sender: UIButton) {
        search(range: rangeSlider.range, genre: .pub)
    }

    @IBAction func searchSweets(_ sender: UIButton) {
        search(range: rangeSlider.range, genre: .sweets)
    }

    @IBOutlet var rangeSlider: RangeSlider!

    private func search(range: Int, genre: GourmetGenre) {
        searchAPI.searchRestaurant(latitude: location.latitude, longitude: location.longitude, range: range, genre: genre, completionHandler: { _ in })
    }
}
