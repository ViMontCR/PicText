//
//  Screen3View.swift
//  PicText
//
//  Created by Viktor Montazer on 28.02.2025.
//

import SwiftUI

struct WordsView: View {
    var words: [String]
    @State var isNextButtonActive = false
    @State var lettersArray: [UniqueCharacter] = []
    
    var body: some View {
        VStack {
            List(words, id: \.self) { word in
                HStack {
                    Text(word)
                    Spacer()
                    Button {
                        // code that filters an array
                        lettersArray = Array(word).map { UniqueCharacter(value: $0) }
                        //lettersArray = word.split(separator: " ").flatMap { Array($0) }
                        //let something = word.split(separator: " ")
                        //lettersArray = word.flatMap { Array(arrayLiteral: $0) }
                        isNextButtonActive = true
                    } label: {
                        Text("Next Page")
                    }
                }
            }
        }
            .navigationDestination(isPresented: $isNextButtonActive, destination: {
                LettersView(letters: lettersArray)
            })
        }
    
}

//#Preview {
//    Screen3View()
//}


