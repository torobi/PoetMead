//
//  Location.swift
//  PoetMead
//
//  Created by torobi on 2023/04/02.
//

import CoreLocation
import Foundation

/// 位置情報を取得する.
/// 取得できなかった場合のデフォルトの座標は東京都(35.66934273241242, 139.76927712572368)
class Location: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private (set) var latitude: Double = 35.66934273241242
    private (set) var longitude: Double = 139.76927712572368

    /// 位置情報の取得を開始する
    func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        locationManager.startUpdatingHeading()
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
