//
//  Location.swift
//  BucketList
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import Foundation
import MapKit

struct Location: Identifiable, Codable, Equatable {
    var id : UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let exampleLocation = Location(id: UUID(), name: "Kedarnath", description: "", latitude: 30.7352, longitude: 79.0669)
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
