//
//  ContentViewModel.swift
//  InstaFilter
//
//  Created by Venkatesh Nyamagoudar on 6/3/23.
//


import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

class ContentViewModel: ObservableObject {
    @Published var image: Image?
    @Published var filterIntensity = 0.5
    @Published var radius = 0.5
    @Published var scale = 0.5
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage?
    @Published var rotationAngle: Double = 0.0
    @Published var processedImage: UIImage?
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    @Published var showingFilterConfirmation = false
    @Published var hideSaveButton = true
    
    private let context = CIContext()
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        hideSaveButton = false
        applyProcessing()
    }
    
    func save() {
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
        }
        
        imageSaver.errorHandler = { error in
            print("Oops: \(error.localizedDescription)")
        }
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(scale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    func rotateImageClockwise() {
        rotationAngle += 90
    }
    
    func rotateImageAnticlockwise() {
        rotationAngle -= 90
    }
}

