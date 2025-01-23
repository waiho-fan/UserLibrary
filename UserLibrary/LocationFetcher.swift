//
//  LocationFetcher.swift
//  UserLibrary
//
//  Created by Gary on 9/1/2025.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    var onLocationUpdate: ((CLLocationCoordinate2D) -> Void)?  // 添加位置更新回調

    
    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            onLocationAuthorized?()  // 當獲得授權時呼叫回調
//        default:
//            break
//        }
//    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        lastKnownLocation = locations.first?.coordinate
        if let location = locations.first?.coordinate {
            lastKnownLocation = location
            onLocationUpdate?(location)  // 當位置更新時呼叫回調
        }
        print("locationManager didUpdateLocations - lastKnownLocation \(String(describing: lastKnownLocation))")
    }
}
