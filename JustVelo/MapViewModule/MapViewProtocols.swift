//
//  Protocols.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 28.09.2021.
//

import UIKit
import MapKit

protocol MapViewProtocol: AnyObject {

    var startButton: UIButton { get }
    var stopButton: UIButton { get }
    var saveTraining: UIButton { get }
    var doNotsaveTraining: UIButton { get }
    var tripPathCoordinates: [CLLocationCoordinate2D] { get set }
    var mapView: MKMapView { get set }
    var distanceLabel: UILabel { get set }
    var speedLabel: UILabel { get set }
    var tripStarted: Bool { get set }
//    var snapView: UIView { get set }

    func setDistanceLabel(distance: Double)
    func centerViewToUserLocation(center: CLLocationCoordinate2D)

}

protocol MapViewPresenterProtocol: AnyObject {
    
    var view: MapViewProtocol? { get set }
    var locationManager: LocationManager { get set }
    var snapShotter: SnapShotter { get }
    var storageManager: StorageManager { get }
    
    init(view: MapViewProtocol, locationManager: LocationManager, snapShotter: SnapShotter, storageManager: StorageManager)
    
    func centerViewToUserLocation(center: CLLocationCoordinate2D)
    func drawPathPassed(tripPathCoordinates: [CLLocationCoordinate2D])
    func setDistanceLabel(locationsPassed: [CLLocationCoordinate2D])
    func startStopButtonTaped(type: String)
    func saveButtonTaped()
    func doNotSaveButtonTaped()
}
