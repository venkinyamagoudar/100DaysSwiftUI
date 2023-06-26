//
//  ContentView.swift
//  BetterRest
//
//  Created by Venkatesh Nyamagoudar on 4/23/23.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeup = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Enter the Time", selection: $wakeup, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("Please Enter the time until you want to sleep")
                        .font(.headline)
                }
                
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Please enter the amount of sleep you need")
                        .font(.headline)
                }
                
                Section {
                    //Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker(coffeeAmount == 1 ? "1 Cup": "\(coffeeAmount) Cups", selection: $coffeeAmount) {
                        ForEach(1..<21) {
                            Text("\($0)")
                        }
                    }
                        .pickerStyle(.navigationLink)
                } header: {
                    Text("Please Enter the amount of cofee you drink")
                        .font(.headline)
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime )
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                    Text(alertMessage)
                }
            }
        }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepData(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeup)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeup - prediction.actualSleep
            alertTitle = "Your Ideal Bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time:.shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry , there was a problem calculating your bed time."
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
