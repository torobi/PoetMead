//
//  Location.swift
//  PoetMead
//
//  Created by torobi on 2023/04/02.
//

import CoreLocation
import Foundation
import UIKit

/// 位置情報を取得する.
extension SearchViewController: CLLocationManagerDelegate {
    /// 位置情報の取得を開始する
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if !CLLocationManager.locationServicesEnabled() {
            let alert = UIAlertController(title: "位置情報サービスを\nオンにして下さい", message: "「設定」アプリ ⇒「プライバシー」⇒「位置情報サービス」からオンにできます", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
        switch status {
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            case .denied: break
            case .restricted: break
            case .authorizedAlways: break
            case .authorizedWhenInUse:
                self.locationManager.requestLocation()
        @unknown default:
            print("unknown status")
        }
    }
}
