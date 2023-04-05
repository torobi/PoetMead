//
//  DetailViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/28.
//

import MapKit
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var mapView: ShopMap!
    @IBOutlet var shopDetailTagList: ShopDetailTagList!

    private var shop: Shop?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let shop else { return }
        mapView.setMap(lat: shop.lat, lng: shop.lng, name: shop.name)
        shopDetailTagList.updateTags(shop: shop)
    }

    func setContent(shop: Shop) {
        self.shop = shop
    }
}
