//
//  ContentView.swift
//  UnitConversion
//
//  Created by Venkatesh Nyamagoudar on 4/22/23.
//

import SwiftUI

enum TemperatureUnit: String, CaseIterable {
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
}

struct ContentView: View {
    
    @State private var inputUnit = TemperatureUnit.celsius
    @State private var outputUnit = TemperatureUnit.celsius
    @State private var inputTemperature = 0.0
    @FocusState private var inputTemperatureFocused: Bool

    var outputTemperature : Double {
        var result:Double
        switch inputUnit {
        case .celsius:
            switch outputUnit {
            case .celsius:
                result = inputTemperature
            case .fahrenheit:
                result = (inputTemperature * 9 / 5) + 32
            case .kelvin:
                result = inputTemperature + 273.15
            }
        case .fahrenheit:
            switch outputUnit {
            case .celsius:
                result = (inputTemperature - 32) * 5 / 9
            case .fahrenheit:
                result = inputTemperature
            case .kelvin:
                result = (inputTemperature + 459.67) * 5 / 9
            }
            
        case .kelvin:
            switch outputUnit {
            case .celsius:
                result = inputTemperature - 273.15
            case .fahrenheit:
                result = (inputTemperature * 9 / 5) - 459.67
            case .kelvin:
                result = inputTemperature
            }
        }
        return result
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select the Unit", selection: $inputUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select input unit")
                }
                
                Section {
                    TextField("Enter the Temperature", value: $inputTemperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputTemperatureFocused)
                } header: {
                    Text("Enetr the input Temperature")
                }
                
                Section {
                    Picker("Select the output unit", selection: $outputUnit) {
                        ForEach(TemperatureUnit.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output unit")
                }
                
                Section {
                    Text(outputTemperature, format: .number)
                } header: {
                    Text("Output Temperature")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputTemperatureFocused = false
                    }
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
