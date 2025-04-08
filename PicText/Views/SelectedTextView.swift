//
//  MyButton.swift
//  PicText
//
//  Created by Viktor Montazer on 26.02.2025.
//


import SwiftUI
import Vision

struct SelectedTextView: View {
    @ObservedObject var selectedText: SelectedText
    var body: some View {
        HStack(alignment: .top) {
            Button {
                selectedText.toggle()
            } label: {
                Image(systemName: "checkmark.square")
                    .tint(selectedText.isActive ? .blue : .gray)
            }
           
            Text(selectedText.text)
            
        }
    }
}
