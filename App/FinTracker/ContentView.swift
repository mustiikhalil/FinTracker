// Copyright Gwen aka Mustii for BuildSwift

import Networth
import SwiftUI
import UserInterface

struct ContentView: View {
  @Environment(\.calendar) private var calendar

  var body: some View {
    TabView {
      Tab("Networth", systemImage: Images.chartUpTrend) {
        NetworthTabView()
      }
    }
    .tabViewStyle(.sidebarAdaptable)
  }
}

#Preview {
  ContentView()
}
