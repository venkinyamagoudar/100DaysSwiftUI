//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import Foundation
import MapKit
import LocalAuthentication


extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 27, longitude: 83), span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        @Published var isUnlocked = false
        @Published var showFaceLockError_Alert = false
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func authenticate() {
            
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                //can use biometrics
                let reason = "Please authenticate yourself to unlock your places."
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {[weak self] result, error in
                    switch result {
                    case true :
                        //checking the biometrics - success case
                        Task { @MainActor in
                            self?.isUnlocked = true
                        }
                    case false:
                        //checking the biometrics - fail case
                        Task { @MainActor in
                            self?.showFaceLockError_Alert = true
                        }
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}
