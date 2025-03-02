//
//  PicTextApp.swift
//  PicText
//
//  Created by Viktor Montazer on 23.02.2025.
//

import SwiftUI
import SwiftData

@main
struct PicTextApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: SampleModel.self)
    }
}
