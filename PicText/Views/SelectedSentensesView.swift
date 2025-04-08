//
//  Screen2View.swift
//  PicText
//
//  Created by Viktor Montazer on 28.02.2025.
//

import SwiftUI

struct SelectedSentensesView: View {
    var selectedTextList: [SelectedText]
    @State var isNextButtonActive = false
    @State var filteredArray: [SelectedText] = []
    @State var wordsArray: [String] = []
    var body: some View {
        VStack {
            if selectedTextList.isEmpty {
                Text("No Text Selected")
                Spacer()
            } else {
                List {
                    ForEach(selectedTextList, id: \.self) { selectedText in
                        HStack {
                            SelectedTextView(selectedText: selectedText)
                            Button {
                                // code that filters an array
                                wordsArray = selectedText.text.components(separatedBy: " ")
                                isNextButtonActive = true
                            } label: {
                                Text("Next Page")
                            }
                        }
                    }
                }
            }
        }
        .navigationDestination(isPresented: $isNextButtonActive, destination: {
            WordsView(words: wordsArray)
        })
    }
}
    




   


