//
//  ContentView.swift
//  PicText
//
//  Created by Viktor Montazer on 23.02.2025.
//

import SwiftUI
import Vision

struct MainView: View {
    var samples: [ImageResource] = [.sample1, .sample2, .sample3]
    @State private var recognizedText = ""
    @State var curentSampleIndex: Int = 0
    @State var resultArray: [String] = []
    @State var myblablaarray: [SelectedText] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Viktor's OCR")
                    .font(.title)
                
                Image(samples[curentSampleIndex])
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                HStack {
                    Button("Previous") {
                        previousImage()
                        
                    }
                    .disabled(curentSampleIndex == 0 ? true : false)
                    .padding()
                    
                    
                    Button {
                        //call OCR function
                        recognizeText()
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.square")
                            Text("Recognize")
                        }
                    }
                    
                    .padding()
                    
                    Button("Next") {
                        nextImage()
                    }
                    .disabled(curentSampleIndex == samples.count - 1 ? true : false)
                    .padding()
                }
                
                List {
                    ForEach(myblablaarray, id: \.self) { item in
                        SelectedTextView(selectedText: item)
                    }
                }
                //TextEditor(text: $recognizedText)
                //
                //          Button("Find") {
                //findText()
                //          }
                NavigationLink("Next Page", value: "1")
                    .disabled(resultArray.isEmpty)
            }
            .padding()
            .navigationDestination(for: String.self) { value in
                SentensesListView(list: myblablaarray)
            }
            .navigationBarTitle("PicTextView", displayMode: .inline)
        }
    }
    
      func previousImage() {
        if curentSampleIndex > 0 {
            curentSampleIndex -= 1
        } else if curentSampleIndex == 0 {
            return
        }
    }
    
    func nextImage() {
        if curentSampleIndex < samples.count - 1 {
            curentSampleIndex += 1
        } else if curentSampleIndex == samples.count - 1 {
            return
        }
    }
    
     func recognizeText() {
        let image = UIImage(resource: samples[curentSampleIndex])
        
        guard let cgImage = image.cgImage else { return }
    
        let handler = VNImageRequestHandler(cgImage: cgImage)
        let request = VNRecognizeTextRequest { request, error in
            guard  error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            guard let result = request.results as?[VNRecognizedTextObservation] else { return }
            
            let recogArr = result.compactMap{result in
                result.topCandidates(1).first?.string
            }
            DispatchQueue.main.async {
                recognizedText = recogArr.joined(separator: " ")
                recognizedText = recognizedText.replacingOccurrences(of: "- ", with: "")
                resultArray = recognizedText.components(separatedBy: ".")
               
                
                myblablaarray = resultArray.map { SelectedText(str: $0, isActive: false)}
            }
        }
        
        request.recognitionLevel = .accurate
        
        do {
            try handler.perform([request])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func findText() {
        let indexOfFullStop = recognizedText.firstIndex(of: ".")!
       
        let beginning = recognizedText[..<indexOfFullStop]
        print(beginning)
    }
}

#Preview {
    MainView()
}
