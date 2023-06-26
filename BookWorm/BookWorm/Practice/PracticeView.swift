//
//  PracticeView.swift
//  BookWorm
//
//  Created by Venkatesh Nyamagoudar on 5/31/23.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.red, Color.yellow]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button(title) {
            isOn.toggle()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct PracticeView: View {
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    @Environment(\.managedObjectContext) var moc
    
    @State private var rememberMe = false
    @AppStorage("notes") private var notes = ""
    var body: some View {
        NavigationView {
            //            ScrollView {
            //                LazyVStack {
            //                    PushButton(title: "Remember Me", isOn: $rememberMe)
            //                    Text(rememberMe ? "On" : "Off")
            //                }
            //            }
            //            TextEditor(text: $notes)
            //                .background(.red)
            //                .navigationTitle("Notes")
            //                .padding()
            VStack{
                List(students) { student in
                    Text(student.name ?? "Unkown")
                }
                Button("Add") {
                    let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                    let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                    
                    let chosenFirstName = firstNames.randomElement()!
                    let chosenLastName = lastNames.randomElement()!
                    
                    let student = Student(context: moc)
                    student.id = UUID()
                    student.name = "\(chosenFirstName) \(chosenLastName)"
                    try? moc.save()
                }
            }
        }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
