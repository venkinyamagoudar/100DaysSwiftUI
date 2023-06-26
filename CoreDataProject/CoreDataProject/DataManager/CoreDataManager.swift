//
//  CoreDataManager.swift
//  CoreDataProject
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import CoreData

class CoreDataManager: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error while loading Core data. \(error.localizedDescription)")
                return
            }
            
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
