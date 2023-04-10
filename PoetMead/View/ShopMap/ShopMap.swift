//
//  MapView.swift
//  PoetMead
//
//  Created by torobi on 2023/04/04.
//

import MapKit
import UIKit

/// 店舗の地図を表示する
class ShopMap: UINibView {
    @IBOutlet var mapView: MKMapView!

    /// 地図を表示するために必要な情報を設定
    /// - parameter srcLat: 現在地の緯度
    /// - parameter srcLng: 現在地の経度
    /// - parameter shopLat: 店舗の緯度
    /// - parameter shopLng: 店舗の経度
    /// - parameter name: 店舗名
    func setMap(srcLat: Double, srcLng: Double, shopLat: Double, shopLng: Double, name: String) {
        // 目的地のピン追加
        let shopLoc = CLLocation(latitude: shopLat, longitude: shopLng)
        let cr = MKCoordinateRegion(center: shopLoc.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(cr, animated: true)

        let pa = MKPointAnnotation()
        pa.title = name
        pa.coordinate = shopLoc.coordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pa)

        // 現在地からのルート検索
        let srcLoc = CLLocation(latitude: srcLat, longitude: srcLng)
        let srcPlaceMark = MKPlacemark(coordinate: srcLoc.coordinate)
        let destPlaceMark = MKPlacemark(coordinate: shopLoc.coordinate)

        let directionRequest = MKDirections.Request()
                directionRequest.source = MKMapItem(placemark: srcPlaceMark)
                directionRequest.destination = MKMapItem(placemark: destPlaceMark)
                directionRequest.transportType = .automobile

        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let directionResonse = response else {
                if let error {
                    print("we have error getting directions==\(error.localizedDescription)")
                }
                return
            }
            //　ルートを追加
            let route = directionResonse.routes[0]
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            //　縮尺を設定
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }

        mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        self.mapView.delegate = self
    }
}

extension ShopMap: MKMapViewDelegate {
    // MARK: - MapKit delegates
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        // 店舗へのルートを表示
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 4.0
        return renderer
    }
}
