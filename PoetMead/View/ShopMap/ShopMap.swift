//
//  MapView.swift
//  PoetMead
//
//  Created by torobi on 2023/04/04.
//

import MapKit
import UIKit

class ShopMap: UINibView {
    @IBOutlet var mapView: MKMapView!

    func setMap(srcLat: Double, srcLng: Double, shopLat: Double, shopLng: Double, name: String, delegate: MKMapViewDelegate) {
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

        self.mapView.delegate = delegate
    }
}
