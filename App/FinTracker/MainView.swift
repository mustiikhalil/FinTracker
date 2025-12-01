// Copyright Gwen aka Mustii for BuildSwift

import Networth
import SwiftUI
import UserInterface

struct MainView: View {
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
  MainView()
}
