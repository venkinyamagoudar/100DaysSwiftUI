//
//  Prospect.swift
//  HotProspects
//
//  Created by Venkatesh Nyamagoudar on 6/5/23.
//

import SwiftUI

class Prospect: Identifiable, Codable{
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var createdDate = Date()
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    let saveKey = "SavedData"
    
    init() {
        
        
        //        if let data = UserDefaults.standard.data(forKey: saveKey) {
        //            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        //                people = decoded
        //                return
        //            }
        //        }
        
        //no saved data!
        self.people = []
        
        //MARK: Challenge 2
        if let data = loadFile() {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.setValue(encoded, forKey: saveKey)
            
            //Challenge 2
            saveFile(data: encoded)
        }
    }
    
    //You should call objectWillChange.send() before changing your property, to ensure SwiftUI gets its animations correct.
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func add(prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    // Challenge 2
    private func loadFile() -> Data? {
        let url = FileManager.documentsDirectory.appendingPathComponent(saveKey)
        if let data = try? Data(contentsOf: url) {
            return data
        }
        return nil
    }
    
    
    // Challenge 2
    private func saveFile(data: Data) {
        let url = FileManager.documentsDirectory.appendingPathComponent(saveKey)
        
        do {
            try data.write(to: url, options: [.atomicWrite, .completeFileProtection])
        }
        catch let error {
            print("Error While writting to file : \(error.localizedDescription)")
        }
    }
}

//Challenge 2
extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
