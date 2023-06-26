//
//  PracticeView.swift
//  BucketList
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct PracticeView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var body: some View {
        NavigationView {
            Form {
                List(users) { user in
                    Text("\(user.lastName), \(user.firstName)")
                        .onTapGesture {
                            let str = "\(user.lastName), \(user.firstName)"
                            let url = getDocumentsDirectory().appendingPathComponent("FullName.txt")
                            
                            do {
                                try str.write(to: url, atomically: true, encoding: .utf8)
                                let input = try String(contentsOf: url)
                                print(input)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                }
                NavigationLink {
                    MapView()
                } label: {
                    Text("Map View")
                }
                NavigationLink {
                    LocalFaceAuth()
                } label: {
                    Text("Auth")
                }
            }
        }
    }
    
    // gives the private directory belongging to the application. no other apps can access this documentary
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return filePath[0]
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
