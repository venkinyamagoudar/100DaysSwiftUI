//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Venkatesh Nyamagoudar on 6/5/23.
//

import SwiftUI
import CodeScanner
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
    enum SortBy {
        case name, recent
    }
    
    let filter: FilterType
    init (filter: FilterType){
        self.filter = filter
    }
    
    //Befor running this code we need to have one object created by using the declaration type
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner: Bool = false
    
    @State private var isShowingSortOptions: Bool = false
    @State private var sortBy: SortBy = .name
    
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none:
            return prospects.people
        case .contacted:
            return prospects.people.filter { $0.isContacted }
        case .uncontacted:
            return prospects.people.filter { !$0.isContacted }
        }
    }
    
    // Challenge 3
    var filteredSortedProspects: [Prospect] {
        switch sortBy {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .recent:
            return filteredProspects.sorted { $0.createdDate > $1.createdDate }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredSortedProspects) { prospect in
                    HStack {
                        // Challenge 1
                        if self.filter == .none {
                            Image(systemName: prospect.isContacted ? "envelope" : "envelope.badge")
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu(menuItems: {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    })
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)
                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind Me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button {
                    isShowingScanner = true
                } label: {
                    Label("Scan", systemImage: "qrcode.viewfinder")
                }
            }
            .navigationBarItems(leading: Button("Sort") {
                self.isShowingSortOptions = true
            }
            )
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\npaul@hackingwithswift.com" ,completion: handleScan)
            }
            // Challenge 3
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text("Sort by"), buttons: [
                    .default(Text((self.sortBy == .name ? "✓ " : "") + "Name"), action: { self.sortBy = .name }),
                    .default(Text((self.sortBy == .recent ? "✓ " : "") + "Most recent"), action: { self.sortBy = .recent }),
                ])
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        // more code to come
        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count  == 2 else {
                return
            }
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            prospects.add(prospect: person)
        case .failure(let error):
            print("Scanning Error: \(error.localizedDescription)")
        }
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            //            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            //            Tip: For testing purposes, I recommend you comment out that trigger code and replace it with the following, which shows the alert five seconds from now:
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        // more code to come
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
