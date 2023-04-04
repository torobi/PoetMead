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

    func setMap(lat: Double, lng: Double, name: String) {
        let loc = CLLocation(latitude: lat, longitude: lng)
        let cr = MKCoordinateRegion(center: loc.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(cr, animated: true)

        let pa = MKPointAnnotation()
        pa.title = name
        pa.coordinate = loc.coordinate
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pa)
    }
}
