// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI

@main
struct FinTrackerApp: App {
  var body: some Scene {
    WindowGroup {
      #if os(macOS)
      MainView()
        .containerBackground(.black, for: .window)
      #else
      MainView()
      #endif
    }
  }
}
