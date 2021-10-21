//
//  SnapShotter.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 28.09.2021.
//

import UIKit
import MapKit

class  SnapShotter {
    
    var snapShot: MKMapSnapshotter!
    
    var center: CLLocationCoordinate2D!
    
    var mySpan: MKCoordinateSpan!
    
    func takeSnapshot(view: MapViewProtocol,
                      region: MKCoordinateRegion,
                      tripPathCoordinates: [CLLocationCoordinate2D]?,
                      completion: @escaping(_ result: UIImage) -> Void) {
        
        let snapShotOptions = MKMapSnapshotter.Options()
        snapShotOptions.region = region
        snapShotOptions.size = view.mapView.frame.size
        snapShotOptions.scale = UIScreen.main.scale
        snapShot = MKMapSnapshotter(options: snapShotOptions)
        
        //        let mapImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 250))
        //
        //        mapImage.contentMode = .scaleAspectFit
        //        mapImage.backgroundColor = .white
        //        mapImage.layer.masksToBounds = true
        //        mapImage.layer.borderWidth = 1.0
        //        mapImage.layer.borderColor = UIColor.red.cgColor
        
        
        snapShot.start { (snapshot, error) -> Void in
            guard let snapshot = snapshot else { return }
            
            let mapImage = snapshot.image
            
            let finalImage = UIGraphicsImageRenderer(size: mapImage.size).image { _ in
                mapImage.draw(at: .zero)
                guard let coordinates = tripPathCoordinates, coordinates.count > 1 else { return }
                let points = coordinates.map { coordinate in
                    snapshot.point(for: coordinate)
                }
                let path = UIBezierPath()
                path.move(to: points[0])
                for point in points.dropFirst() {
                    path.addLine(to: point)
                }
                
                path.lineWidth = 1
                UIColor.blue.setStroke()
                path.stroke()
            }
            completion(finalImage)
        }
    }
}

