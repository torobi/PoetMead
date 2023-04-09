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

    @IBOutlet var name: UILabel!
    @IBOutlet var shopImage: UIImageView!
    @IBOutlet var shopImageBackground: UIImageView!
    @IBOutlet var catchMemo: UILabel!
    @IBOutlet var openInfo: UILabel!
    @IBOutlet var address: UILabel!

    private var shop: Shop?
    private var srcLat: Double?
    private var srcLng: Double?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let shop else { return }

        setupNavigationItem()
        setupShopBasicInfo(shop)
        setupMapView(shop)
        setupDetailTagList(shop)
        setupScrollView()
    }

    private func setupNavigationItem() {
        navigationItem.title = "店舗詳細"
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupShopBasicInfo(_ shop: Shop) {
        name.text = shop.name
        catchMemo.text = shop.`catch`
        openInfo.text = shop.open

        fetchImage(imageUrl: shop.photo.largeImageUrl) { image in
            DispatchQueue.main.async {
                self.shopImage.image = image
                self.shopImageBackground.image = image
            }
        }
    }

    private func setupDetailTagList(_ shop: Shop) {
        shopDetailTagList.updateTags(shop: shop)
    }

    private func setupMapView(_ shop: Shop) {
        guard let srcLat else {
            print("srcLat is nil")
            return
        }
        guard let srcLng else {
            print("srcLng is nil")
            return
        }
        mapView.setMap(srcLat: srcLat, srcLng: srcLng, shopLat: shop.lat, shopLng: shop.lng, name: shop.name, delegate: self)
        address.text = shop.address
    }

    private func setupScrollView() {
        scrollView.contentSize = contentView.frame.size
        scrollView.flashScrollIndicators()
    }

    func setContent(shop: Shop) {
        self.shop = shop
    }

    func setSrcLocation(_ srcLng: Double, _ srcLat: Double) {
        self.srcLng = srcLng
        self.srcLat = srcLat
    }
}

extension DetailViewController: MKMapViewDelegate {
    // MARK: - MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}
