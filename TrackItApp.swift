//
//  TrackItApp.swift
//  TrackIt
//
//  Created by Nikita on 03/03/2026.
//

import SwiftUI
import SwiftData

@main
struct TrackItApp: App {
    var body: some Scene {
        WindowGroup {
            TrackItMainView()
        }
        .modelContainer(for: Day.self)
    }
}
