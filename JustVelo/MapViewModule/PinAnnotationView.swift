//
//  PinAnnotationView.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 28.09.2021.
//

import UIKit
import MapKit

enum PinType: String, RawRepresentable {
    case start
    case finish
    
    func image() -> UIImage {
        switch self {
        case .start:
            return UIImage(imageLiteralResourceName: "start")
        case .finish:
            return UIImage(imageLiteralResourceName: "finish")
        }
    }
}

class PinAnnotation: NSObject, MKAnnotation {
    
    let coordinate: CLLocationCoordinate2D
    let type: PinType
    
    init(
        coordinate: CLLocationCoordinate2D,
        type: PinType
    ) {
        self.coordinate = coordinate
        self.type = type
    }
}

class PinStartStopAnnotationView: MKAnnotationView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        guard let pinAnnotation = self.annotation as? PinAnnotation else {
            return
        }

        image = pinAnnotation.type.image()
    }
}
