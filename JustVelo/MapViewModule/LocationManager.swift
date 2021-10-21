//
//  LocationManager.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 24.09.2021.
//

import CoreLocation
import UIKit

protocol LocationManagerProtocol {
    static func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus, view: MapViewProtocol)
}

class LocationManager: LocationManagerProtocol {

    var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        return manager
    }()
    
    static func handleAuthorizationStatus(locationManager: CLLocationManager, status: CLAuthorizationStatus, view: MapViewProtocol) {
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let view = view as! UIViewController
                view.showAlert(title: "Access to your location is restricted", message: "To allow full acccess go to Settings -> Privacy -> turn it On")
            }
            break
        case .denied:
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let view = view as! UIViewController
                view.showAlert(title: "Access to your location is denied", message: "To enable the service go to Settings -> Privacy -> turn it On")
            }
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            if let center = locationManager.location?.coordinate {
                view.centerViewToUserLocation(center: center)
            }
            break
        @unknown default:
            break
        }
    }
    
    func refreshDistance(locationsPassed: [CLLocationCoordinate2D]) -> Double {
        guard let first = locationsPassed.first else { return 0.0 }
        var prevPoint = first
        return locationsPassed.reduce(0.0) { (count, point) -> Double in
            let newCount = count + CLLocation(latitude: prevPoint.latitude, longitude: prevPoint.longitude).distance(
                from: CLLocation(latitude: point.latitude, longitude: point.longitude))
            prevPoint = point
            return newCount
        }
    }
}
