//
//  MapView.swift
//  BucketList
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI
import MapKit

//30.7448° N, 79.4913° E

struct MapView: View {
    
    //you can change the zoom by changing the span values
    //go to a place getting the coordinates directly
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.7352, longitude: 79.0669),span: MKCoordinateSpan(latitudeDelta: 0.0001, longitudeDelta: 0.0001))
    
    let locations = [
        Location(id: UUID(), name: "Kedarnath", description: "", latitude: 30.7352, longitude: 79.0669),
        Location(id: UUID(), name: "Badrinath", description: "", latitude: 30.7448, longitude: 79.4913)
    ]
    
    var body: some View {
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("Temples")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
