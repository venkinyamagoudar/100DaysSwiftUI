//
//  AddBookView.swift
//  BookWorm
//
//  Created by Venkatesh Nyamagoudar on 5/31/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var genre: String = ""
    
    @State private var rating: Int = 0
    @State private var review: String = ""
    
    var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("Enter book details")
                }
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                Section() {
                    Button("Add Book") {
                        //call add method
                        addBook()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func addBook() {
        let book = Book(context: managedObjectContext)
        book.id = UUID()
        book.title = title
        book.author = author
        book.genre = genre
        book.rating = Int16(rating)
        book.review = review
        //Challenge 3
        book.date = Date.now
        
        try? managedObjectContext.save()
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
