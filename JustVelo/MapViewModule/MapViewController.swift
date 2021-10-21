//
//  MapView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 23.09.2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var presenter: MapViewPresenterProtocol!
    
    var tripStarted = false
    
    var tripPathCoordinates: [CLLocationCoordinate2D] = []
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.showsUserLocation = true
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsCompass = true
        return map
    }()
    
    let startButton = UIButton(title: "Start", isHidden: false)
    let stopButton = UIButton(title: "Finish")
    let saveTraining = UIButton(title: "Save")
    let doNotsaveTraining = UIButton(title: "Not now")
    
//    var snapView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 250))
//        return view
//    }()
    
    var distanceLabel = UILabel(text: "0m", font: .boldSystemFont(ofSize: 26), color: .red)
    var speedLabel = UILabel(text: "0km/h", font: .boldSystemFont(ofSize: 26), color: .green)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        initializeMapView()
    }
    
    // Inintial method who set all the initial functions of the view
    private func initializeMapView() {
        startButton.addTarget(self, action: #selector(startButtonTaped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTaped), for: .touchUpInside)
        saveTraining.addTarget(self, action: #selector(saveButtonTaped), for: .touchUpInside)
        doNotsaveTraining.addTarget(self, action: #selector(doNotSaveButtonTaped), for: .touchUpInside)
        presenter.locationManager.locationManager.delegate = self
        presenter.locationManager.locationManager.startUpdatingLocation()
        presenter.locationManager.locationManager.startUpdatingHeading()
        centerViewToUserLocation(center: presenter.locationManager.locationManager.location?.coordinate ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
        mapView.userTrackingMode = .followWithHeading
        if CLLocationManager.locationServicesEnabled() {
            presenter.locationManager.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationManager.handleAuthorizationStatus(locationManager: presenter.locationManager.locationManager,
                                                      status: presenter.locationManager.locationManager.authorizationStatus, view: self)
        } else {
            print("Location services are disabled")
        }
    }
    
    // Setups constraints of all elements on the view
    func setupConstraints() {
        view.backgroundColor = .white
        mapView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        speedLabel.translatesAutoresizingMaskIntoConstraints = false
        saveTraining.translatesAutoresizingMaskIntoConstraints = false
        doNotsaveTraining.translatesAutoresizingMaskIntoConstraints = false
//        snapView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mapView)
        view.addSubview(startButton)
        view.addSubview(stopButton)
        view.addSubview(distanceLabel)
        view.addSubview(speedLabel)
        view.addSubview(saveTraining)
        view.addSubview(doNotsaveTraining)
//        view.addSubview(snapView)
        distanceLabel.layer.opacity = 0.7
        distanceLabel.isHidden = true
        speedLabel.layer.opacity = 0.7
        speedLabel.isHidden = true
        
        view.bringSubviewToFront(startButton)
        view.bringSubviewToFront(stopButton)
        view.bringSubviewToFront(stopButton)
        view.bringSubviewToFront(saveTraining)
        view.bringSubviewToFront(doNotsaveTraining)
//        view.bringSubviewToFront(snapView)
        
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: self.view.bounds.height),
            mapView.widthAnchor.constraint(equalToConstant: self.view.bounds.width)
        ])
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            stopButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            stopButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            distanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            distanceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
        
        NSLayoutConstraint.activate([
            saveTraining.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            saveTraining.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            doNotsaveTraining.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            doNotsaveTraining.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            speedLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 8),
            speedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        ])
    }

}

extension MapViewController: MapViewProtocol {

    func setDistanceLabel(distance: Double) {
        distanceLabel.text = distance.distanceFarmatter()
    }
    
    func centerViewToUserLocation(center: CLLocationCoordinate2D) {
        presenter.centerViewToUserLocation(center: center)
    }
    
    @objc func startButtonTaped() {
        presenter.startStopButtonTaped(type: "start")
    }
    
    @objc func stopButtonTaped() {
        presenter.startStopButtonTaped(type: "finish")
    }
    
    @objc func saveButtonTaped() {
        presenter.saveButtonTaped()
    }
    
    @objc func doNotSaveButtonTaped() {
        presenter.doNotSaveButtonTaped()
    }
    
//    func setupUserTrackingButtonAndScaleView() {
//        mapView.showsUserLocation = true
//
//        let button = MKUserTrackingButton(mapView: mapView)
//        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.borderWidth = 1
//        button.layer.cornerRadius = 5
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//
//        let scale = MKScaleView(mapView: mapView)
//        scale.legendAlignment = .trailing
//        scale.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scale)
//
//        NSLayoutConstraint.activate([button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//                                     button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//                                     scale.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -10),
//                                     scale.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
//    }
}

extension MapViewController: MKMapViewDelegate {
    
    // Draws route of the bike rider
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = .systemBlue.withAlphaComponent(0.5)
            renderer.lineWidth = 10
            return renderer
        }
        return MKOverlayRenderer()
    }
    
    // Sets picture for start and finish points of the route
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
       
        if annotation is MKUserLocation {
                return nil
            }
        
        let annotationView = PinStartStopAnnotationView(annotation: annotation,
                                                        reuseIdentifier: "StartStopAnnotation")
        annotationView.frame.size = CGSize(width: 30, height: 30)
        return annotationView
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    //Sets distnace label value and route path drawing every single change of the rider coordinates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if tripStarted {
            if let location = locations.last {
                let center = location.coordinate
                let speed = location.speed * 3.6
                speedLabel.text = "\(String(format: "%.1f", speed))km/h"
//                centerViewToUserLocation(center: center)
                mapView.userTrackingMode = .followWithHeading
                tripPathCoordinates.append(center)
                presenter.setDistanceLabel(locationsPassed: tripPathCoordinates)
                presenter.drawPathPassed(tripPathCoordinates: tripPathCoordinates)
            }
        }
//        else {
//            if let location = locations.last {
//                let center = location.coordinate
//                centerViewToUserLocation(center: center)
//            }
//        }
    }
    
    // Handles application authorization from user
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        LocationManager.handleAuthorizationStatus(locationManager: presenter.locationManager.locationManager,
                                                  status: manager.authorizationStatus, view: self)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        mapView.camera.heading = newHeading.magneticHeading
        mapView.setCamera(mapView.camera, animated: true)
    }
}

