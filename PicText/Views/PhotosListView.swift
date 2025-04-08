//
//  PhotosListView.swift
//  PicText
//
//  Created by Viktor Montazer on 02.03.2025.
//

import SwiftUI
import SwiftData

struct PhotosListView: View {
    @Query(sort: \SampleModel.name) var Samples: [SampleModel]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        NavigationStack {
            Group {
                if Samples.isEmpty {
                    ContentUnavailableView("Add your first foto", systemImage: "photo")
                } else {
                    //Photos List
                    List(Samples) { sample in
                        NavigationLink(value: sample) {
                            HStack {
                                Image(uiImage: sample.image == nil ?
                                      Constants.placeholder : sample.image!)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .padding(.trailing)
                              Text(sample.name)
                                    .font(.title)
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(sample)
                                try? modelContext.save()
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationDestination(for: SampleModel.self) { sample in
                SampleView(sample: sample)
            }
            .navigationTitle("Picker or Camera")
            .toolbar {
                Button {
                    
                }label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    PhotosListView()
        .modelContainer(SampleModel.preview)
}
