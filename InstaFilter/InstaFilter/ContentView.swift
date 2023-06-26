//
//  ContentView.swift
//  InstaFilter
//
//  Created by Venkatesh Nyamagoudar on 6/2/23.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

// ContentView.swift
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader { geometry in
                    ZStack {
                        Rectangle()
                            .fill(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(20)
                            
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                        viewModel.image?
                            .resizable()
                            .scaledToFit()
                            .rotationEffect(.degrees(viewModel.rotationAngle))
                            .padding(.horizontal)
                    }
                    .onTapGesture {
                        viewModel.showingImagePicker = true
                    }
                    .frame(width: geometry.size.width,
                           height: max(geometry.size.width, geometry.size.height))
                    .aspectRatio(contentMode: .fit)
                }
                
                HStack {
                    Button {
                        viewModel.rotateImageAnticlockwise()
                    } label: {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.title)
                    }
                    Button {
                        viewModel.rotateImageClockwise()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                    }
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $viewModel.filterIntensity)
                        .onChange(of: viewModel.filterIntensity) { _ in viewModel.applyProcessing() }
                }
                .padding(.top)
                HStack {
                    Text("Radius")
                    Slider(value: $viewModel.radius)
                        .onChange(of: viewModel.radius) { _ in viewModel.applyProcessing() }
                }
                HStack {
                    Text("Scale")
                    Slider(value: $viewModel.scale)
                        .onChange(of: viewModel.scale) { _ in viewModel.applyProcessing() }
                }
                HStack {
                    Button("Change Filter") {
                        viewModel.showingFilterConfirmation.toggle()
                    }
                    Spacer()
                    Button("Save", action: viewModel.save)
                        .disabled(viewModel.hideSaveButton)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
            .sheet(isPresented: $viewModel.showingImagePicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .confirmationDialog("Select Filter", isPresented: $viewModel.showingFilterConfirmation) {
                Button("Crystallize") { viewModel.setFilter(CIFilter.crystallize()) }
                Button("Edges") { viewModel.setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { viewModel.setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { viewModel.setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { viewModel.setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { viewModel.setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { viewModel.setFilter(CIFilter.vignette()) }
                Button("Comic Effect") { viewModel.setFilter(CIFilter.comicEffect()) }
                Button("Bloom") { viewModel.setFilter(CIFilter.bloom()) }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new filter to apply to the image")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
