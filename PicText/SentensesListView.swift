//
//  Screen1View.swift
//  PicText
//
//  Created by Viktor Montazer on 26.02.2025.
//

import SwiftUI


struct SentensesListView: View {
    var list: [SelectedText]
    @State var isNextButtonActive = false
    @State var filteredArray: [SelectedText] = []
    var body: some View {
        VStack {
            List {
                ForEach(list, id: \.self) { item in
                    SelectedTextView(selectedText: item)
                }
            }
            Button {
                // code that filters an array
                filteredArray = list.filter { $0.isActive == true }
                isNextButtonActive = true
            } label: {
                Text("Next Page")
            }
        }
        .navigationDestination(isPresented: $isNextButtonActive, destination: {
            SelectedSentensesView(selectedTextList: filteredArray)
        })
        .navigationBarTitle("Screen1View", displayMode: .inline)
        .padding()
    }
}
