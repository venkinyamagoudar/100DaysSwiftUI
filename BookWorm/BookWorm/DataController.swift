//
//  DataController.swift
//  BookWorm
//
//  Created by Venkatesh Nyamagoudar on 5/31/23.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { descriptio, error in
            if let error = error {
                print("Error while loading Core data. \(error.localizedDescription)")
            }
        }
    }
}
