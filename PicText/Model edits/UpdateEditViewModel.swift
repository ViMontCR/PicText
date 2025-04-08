//
//  UpdateEditViewModel.swift
//  PicText
//
//  Created by Viktor Montazer on 10.03.2025.
//

import UIKit

@Observable
class UpdateEditFormViewModel {
    var name: String = ""
    var data: Data?
    
    var sample: SampleModel?
    
    var image: UIImage? {
        if let data, let uiImage = UIImage(data: data) {
            return uiImage
        }
        else {
            return Constants.placeholder
        }
    }
    
    init() {}
    init(sample: SampleModel) {
        self.sample = sample
        self.name = sample.name
        self.data = sample.data
    }
    
    @MainActor
    func clearImage() {
        data = nil
    }
    
    var isUpDating: Bool { sample != nil }
    var isDisabled: Bool { name.isEmpty }
}
