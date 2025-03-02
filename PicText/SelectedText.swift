//
//  IsActiveString.swift
//  PicText
//
//  Created by Viktor Montazer on 26.02.2025.
//


import SwiftUI
import Vision

class SelectedText: Identifiable, Hashable, Equatable, ObservableObject {
    var text: String
    @Published var isActive: Bool
    
    init(str: String, isActive: Bool = false) {
        self.text = str
        self.isActive = isActive
    }
    
    func toggle() {
        isActive.toggle()
    }
    
    var id: String {
        text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
    static func == (lhs: SelectedText, rhs: SelectedText) -> Bool {
        lhs.text == rhs.text
    }
}
