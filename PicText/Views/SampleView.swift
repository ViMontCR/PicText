//
//  SampleView.swift
//  PicText
//
//  Created by Viktor Montazer on 02.03.2025.
//

import SwiftUI
import SwiftData

struct SampleView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dissmiss
    let sample: SampleModel
    var body: some View {
        VStack {
            Text(sample.name)
                .font(.largeTitle)
            Image(uiImage: sample.image == nil ? Constants.placeholder : sample.image!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding()
            HStack {
                Button("Edit") {
                    
                }
                
                Button("Delete", role : .destructive) {
                    modelContext.delete(sample)
                    try? modelContext.save()
                    dissmiss()
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .trailing)
            Spacer()
        }
        .padding()
        .navigationTitle("Sample View")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let container = SampleModel.preview
    let fetchDescriptor = FetchDescriptor<SampleModel>()
    let sample = try! container.mainContext.fetch(fetchDescriptor)[0]
    return NavigationStack {SampleView(sample: sample)}
}
