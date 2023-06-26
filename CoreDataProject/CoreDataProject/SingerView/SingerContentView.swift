//
//  SingerContentView.swift
//  CoreDataProject
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import SwiftUI

//Challenge
enum Predicates: String {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case beginsWithIgnoreCase = "BEGINSWITH[c]"
    case containsIgnoreCase = "CONTAINS[c]"
}

struct SingerContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var lastNameFilter = "A"
    
    // challenge
    private var sortBy = [NSSortDescriptor(key: "lastName", ascending: true)]
    
    var body: some View {
        VStack {
            //            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
            //                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            //            }
            
//        Challenge
            FilteredList(predicate: .beginsWith, filterKey: "lastName", filterValue: lastNameFilter,sortDescriptors: sortBy) { (singer:Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct SingerContentView_Previews: PreviewProvider {
    static var previews: some View {
        SingerContentView()
    }
}
