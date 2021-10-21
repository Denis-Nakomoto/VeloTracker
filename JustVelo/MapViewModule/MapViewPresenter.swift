//  MainPresenter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 22.09.2021.

import UIKit
import MapKit
import CoreData

class MapViewPresenter: MapViewPresenterProtocol {
    
    var storageManager: StorageManager
    weak var view: MapViewProtocol?
    var locationManager: LocationManager
    var snapShotter: SnapShotter
    var newTraining: Training?
    var timeAndDateOfTheTraining: Date?

    required init(view: MapViewProtocol, locationManager: LocationManager, snapShotter: SnapShotter, storageManager: StorageManager) {
        self.view = view
        self.locationManager = locationManager
        self.snapShotter = snapShotter
        self.storageManager = storageManager
    }

    func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
        view?.mapView.setRegion(region, animated: true)
    }

    //Draws polyline which is path passed by user during the current training
    func drawPathPassed(tripPathCoordinates: [CLLocationCoordinate2D] = []) {
        let polyline = MKPolyline(coordinates: tripPathCoordinates, count: tripPathCoordinates.count)
        view?.mapView.addOverlay(polyline)
    }

    func setDistanceLabel(locationsPassed: [CLLocationCoordinate2D] = []) {
        let distance = locationManager.refreshDistance(locationsPassed: locationsPassed)
        view?.setDistanceLabel(distance: distance)
    }

    func startStopButtonTaped(type: String) {

        if let coordinate = locationManager.locationManager.location?.coordinate {
            let type = PinType(rawValue: type) ?? .start
            let pinAnnotation = PinAnnotation(coordinate: coordinate, type: type)
            view?.mapView.addAnnotation(pinAnnotation)
            view?.tripPathCoordinates.append(coordinate)
        }
        view?.tripStarted.toggle()

        if type == "start" {
            view?.distanceLabel.isHidden.toggle()
            view?.speedLabel.isHidden.toggle()
            timeAndDateOfTheTraining = Date()
            view?.startButton.isHidden.toggle()
            view?.stopButton.isHidden.toggle()
        } else {
            view?.stopButton.isHidden.toggle()
            view?.saveTraining.isHidden.toggle()
            view?.doNotsaveTraining.isHidden.toggle()
            view?.speedLabel.text = "0km/h"
            setRegionForSnapshot()
        }
    }
    
    func saveButtonTaped() {
        let group = DispatchGroup()
        group.enter()
        var pathPassedData: Data?
        let distancePassed = view?.distanceLabel.text
        let dateOfTraining = timeAndDateOfTheTraining ?? Date()
        let snapShotRegion = setRegionForSnapshot()
        
        snapShotter.takeSnapshot(view: view!, region: snapShotRegion) { result in
            defer { group.leave() }
            pathPassedData = result.image?.pngData()
        }
        
        prepareMapForNextTraining()
        
        group.notify(queue: .global(qos: .utility)) {
            self.storageManager.addNewTraining(date: dateOfTraining,
                                          pathPassed: pathPassedData,
                                          distance: distancePassed ?? "0m") { training in
            }
        }
    }
    
    func doNotSaveButtonTaped() {
        prepareMapForNextTraining()
    }
    
    func prepareMapForNextTraining() {
        view?.distanceLabel.isHidden.toggle()
        view?.speedLabel.isHidden.toggle()
        view?.saveTraining.isHidden.toggle()
        view?.startButton.isHidden.toggle()
        view?.doNotsaveTraining.isHidden.toggle()
        view?.distanceLabel.text = "0m"
        view?.mapView.removeAnnotations((view?.mapView.annotations)!)
        view?.mapView.removeOverlays((view?.mapView.overlays)!)
        view?.tripPathCoordinates.removeAll()
    }
    
// Calculate region that fits all the path passed during the training
    @discardableResult func setRegionForSnapshot() -> MKCoordinateRegion {
        let coordinates = view?.tripPathCoordinates

        let ((minLatitude, maxLatitude),
             (minLongitude, maxLongitude)) = coordinates!.reduce(((.greatestFiniteMagnitude,
                                                                   .leastNormalMagnitude),
                                                                  (.greatestFiniteMagnitude,
                                                                   .leastNormalMagnitude))) { r, c in
                 ((min(c.latitude,r.0.0), max(c.latitude, r.0.1)),
                  (min(c.longitude, r.1.0), max(c.longitude, r.1.1)))
             }

        let latitudeDelta = maxLatitude - minLatitude
        let longitudeDelta = maxLongitude - minLongitude
        let zoom = MKCoordinateSpan(latitudeDelta: latitudeDelta + 0.01, longitudeDelta: longitudeDelta + 0.01)
        let location = CLLocationCoordinate2D(latitude: (maxLatitude+minLatitude)*0.5, longitude: (maxLongitude+minLongitude)*0.5)
        let region = MKCoordinateRegion(center: location, span: zoom)
        view?.mapView.setRegion(region, animated: true)
        return region
    }
    
}
