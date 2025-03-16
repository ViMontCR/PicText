//
//  UpdateEditFormView.swift
//  PicText
//
//  Created by Viktor Montazer on 10.03.2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct UpdateEditFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State var vm: UpdateEditFormViewModel
    @State private var imagePicker = ImagePicker()
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $vm.name)
                VStack {
                    if let validData = vm.data {
                        Button("Clear image") {
                            vm.clearImage()
                        }
                        .buttonStyle(.bordered)
                    }
                    HStack {
                        Button("Camera", systemImage: "camera") {
                            
                        }
                        PhotosPicker(selection: $imagePicker.imageSelection) {
                            Label("Photos", systemImage: "photo")
                        }
                    }
                    .foregroundStyle(.white)
                    .buttonStyle(.borderedProminent)
                    if let validImage = vm.image {
                        Image(uiImage: validImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                    }
                   
                }
            }
            .onAppear {
                imagePicker.setup(vm)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading ) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Text(vm.isUpDating ? "Update" : "Add")
                    }
                    .disabled(vm.isDisabled)
                }
            }
        }
    }
}

#Preview {
    UpdateEditFormView(vm: UpdateEditFormViewModel())
}
