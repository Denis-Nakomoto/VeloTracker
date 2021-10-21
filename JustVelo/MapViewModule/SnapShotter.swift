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
    var snapShotOptions = MKMapSnapshotter.Options()
    var center: CLLocationCoordinate2D!

    var mySpan: MKCoordinateSpan!

    func takeSnapshot(view: MapViewProtocol,
                      region: MKCoordinateRegion,
                      completion: @escaping(_ result: UIImageView) -> Void) {

        snapShotOptions.region = region
        snapShotOptions.size = view.mapView.frame.size
        snapShotOptions.scale = UIScreen.main.scale
        snapShot = MKMapSnapshotter(options: snapShotOptions)

        let myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 250))

        myImageView.contentMode = .scaleAspectFit
        myImageView.backgroundColor = .white
        myImageView.layer.masksToBounds = true
        myImageView.layer.borderWidth = 1.0
        myImageView.layer.borderColor = UIColor.red.cgColor

        snapShot.start { (snapshot, error) -> Void in
            if error == nil {
                myImageView.image = snapshot!.image
                completion(myImageView)
            } else {
                print("error")
            }
        }
    }
    
}

