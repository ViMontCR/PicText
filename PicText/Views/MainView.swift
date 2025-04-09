//
//  ContentView.swift
//  PicText
//
//  Created by Viktor Montazer on 23.02.2025.
//

import SwiftUI
import Vision

struct MainView: View {
    @ObservedObject var model: SampleImagesModel = .init()
    @State private var recognizedText = ""
    @State var resultArray: [String] = []
    @State var selectedTexts: [SelectedText] = []

    var body: some View {
        NavigationStack {
            VStack {
                titleView
                
                sampleImageView
                
                functionalPannelButtons
                
                List {
                    ForEach(selectedTexts, id: \.self) { item in
                        SelectedTextView(selectedText: item)
                    }
                }
                
                NavigationLink("Next Page", value: "1")
                    .disabled(resultArray.isEmpty)
            }
            .padding()
            .navigationDestination(for: String.self) { value in
                SentensesListView(list: selectedTexts)
            }
            .navigationBarTitle("PicTextView", displayMode: .inline)
        }
    }
    
    var titleView: some View {
        Text("Viktor's OCR")
            .font(.title)
            .italic()
    }
    
    var sampleImageView: some View {
        Image(model.currentImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var functionalPannelButtons: some View {
        HStack {
            Button("Previous") {
                walkToPreviousImage()
            }
            .disabled(model.isPreviousDisabled())
            .padding()
            
            Button {
                //call OCR function
                recognizeTextFromImage()
            } label: {
                HStack {
                    Image(systemName: "checkmark.square")
                    Text("Recognize")
                }
            }
            .padding()
            
            Button("Next") {
                walkToNextImage()
            }
            .disabled(model.isNextDisabled())
            .padding()
        }
    }
    
    func walkToPreviousImage() {
        model.previousImage()
    }
    
    func walkToNextImage() {
        model.nextImage()
    }
    
    func recognizeTextFromImage() {
        let currentImage = UIImage(resource: model.currentImage)
        
        guard let cgCurrentImage = currentImage.cgImage else { return }
    
        let requestHandler = VNImageRequestHandler(cgImage: cgCurrentImage)
        let request = VNRecognizeTextRequest { request, error in
            guard  error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            guard let textObservations = request.results as?[VNRecognizedTextObservation] else { return }
            
            let recognizedTexts = textObservations.compactMap{result in
                result.topCandidates(1).first?.string
            }
            DispatchQueue.main.async {
                recognizedText = recognizedTexts.joined(separator: " ")
                recognizedText = recognizedText.replacingOccurrences(of: "- ", with: "")
                resultArray = recognizedText.components(separatedBy: ".")
               
                selectedTexts = resultArray.map { SelectedText(str: $0, isActive: false)}
            }
        }
        
        request.recognitionLevel = .accurate
        
        do {
            try requestHandler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func findFullStop() {
        let indexOfFullStop = recognizedText.firstIndex(of: ".")!
        let beginning = recognizedText[..<indexOfFullStop]
        print(beginning)
    }
}

#Preview {
    MainView()
}
