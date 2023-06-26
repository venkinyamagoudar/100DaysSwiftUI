//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: [], predicate: nil) var movies: FetchedResults<Movie>
    

    var body: some View {
        VStack {
            List(movies, id: \.self) { movie in
                Text(movie.title ?? "Unknown")
            }

            Button("Add") {
                let movie = Movie(context: moc)
                movie.title = "Harry Potter"
                movie.director = "me"
                movie.year = 2009
            }

            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
