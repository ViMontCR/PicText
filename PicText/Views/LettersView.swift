//
//  LettersView.swift
//  PicText
//
//  Created by Viktor Montazer on 02.03.2025.
//

import SwiftUI

struct UniqueCharacter: Identifiable {
    let value: Character
    let id = UUID()
}

struct LettersView: View {
   var letters : [UniqueCharacter]
    var body: some View {
        List(letters) { letter in
            Text(String(letter.value))
        }
    }
}

//#Preview {
//    LettersView(letters: <#[Character]#>)
//}
