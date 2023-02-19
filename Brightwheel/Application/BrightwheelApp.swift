//
//  BrightwheelApp.swift
//  Brightwheel
//
//  Created by Petr Šmejkal on 18.02.2023.
//

import SwiftUI

@main
struct BrightwheelApp: App {
    var body: some Scene {
        WindowGroup {
            TopRepositoriesView(viewModel: TopRepositoriesViewModel())
        }
    }
}
