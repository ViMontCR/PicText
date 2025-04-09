//
//  SampleImagesModel.swift
//  PicText
//
//  Created by Viktor Montazer on 09.04.2025.
//


import SwiftUI
import Vision
 
protocol ImagesModel {
    var currentImage: ImageResource { get }
    func previousImage()
    func nextImage()
    func isPreviousDisabled() -> Bool
    func isNextDisabled() -> Bool 
}

class SampleImagesModel: ObservableObject, ImagesModel {
    private var sampleImages: [ImageResource] = [.sample1, .sample2, .sample3]
    @Published private var curentSampleIndex: Int = 0
    
    var currentImage: ImageResource {
        sampleImages[curentSampleIndex]
    }
    func previousImage() {
        if curentSampleIndex > 0 {
            curentSampleIndex -= 1
        } else if curentSampleIndex == 0 {
            return
        }
    }
    func nextImage() {
        if curentSampleIndex < sampleImages.count - 1 {
            curentSampleIndex += 1
        } else if curentSampleIndex == sampleImages.count - 1 {
            return
        }
    }
    func isPreviousDisabled() -> Bool {
        curentSampleIndex == 0 ? true : false
    }
    func isNextDisabled() -> Bool {
        curentSampleIndex == sampleImages.count - 1 ? true : false
    }
}
