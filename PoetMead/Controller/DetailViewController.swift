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

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    private var shop: Shop?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let shop else { return }
        mapView.setMap(lat: shop.lat, lng: shop.lng, name: shop.name)
        shopDetailTagList.updateTags(shop: shop)

        print(scrollView.contentSize)
        print(contentView.frame.size)

        scrollView.contentSize = contentView.frame.size
        scrollView.flashScrollIndicators()
        print(scrollView.contentSize)
    }

    func setContent(shop: Shop) {
        self.shop = shop
    }
}
