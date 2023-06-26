//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @StateObject private var coredataManager = CoreDataManager()
    
    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, coredataManager.container.viewContext)
            SingerContentView()
                .environment(\.managedObjectContext, coredataManager.container.viewContext)
            
//            CandyContentView()
//                .environment(\.managedObjectContext, coredataManager.container.viewContext)
        }
    }
}


