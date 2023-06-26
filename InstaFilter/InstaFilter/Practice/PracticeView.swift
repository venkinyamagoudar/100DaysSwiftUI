//
//  PracticeView.swift
//  InstaFilter
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import SwiftUI

struct PracticeView: View {
    @State private var blurAmount = 0.0
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                    .blur(radius: blurAmount)
                
                Slider(value: $blurAmount, in: 0...20)
                    .onChange(of: blurAmount) { newValue in
                        print("New value is \(newValue)")
                    }
                
                Button("Random Blur") {
                    blurAmount = Double.random(in: 0...20)
                }
                .padding()
                NavigationLink {
                    ConfiramationPracticeView()
                } label: {
                    Text("GO to Confirmation View")
                }
                
                NavigationLink {
                    CoreImageView()
                } label: {
                    Text("GO to CoreImageView")
                }
                .padding()
                
                NavigationLink {
                    ImagePickerView()
                } label: {
                    Text("GO to CoreImageView")
                }
                
            }
        }
    }
}

struct ConfiramationPracticeView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello, World!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                showingConfirmation = true
            }
            .confirmationDialog("Change background", isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green }
                Button("Blue") { backgroundColor = .blue }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color")
            }
    }
}

struct PravticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
