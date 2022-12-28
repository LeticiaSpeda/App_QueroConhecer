//
//  PlaceAnnotation.swift
//  QueroConhecer
//
//  Created by Leticia Speda on 22/12/22.
//

import UIKit
import MapKit

final class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: PlaceType?
    var address: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil, type: PlaceType? = nil, address: String? = nil) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
        self.address = address
    }
    
}
