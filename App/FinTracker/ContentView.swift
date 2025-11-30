// Copyright Gwen aka Mustii for BuildSwift

import Networth
import SwiftUI
import UserInterface

struct ContentView: View {
  @Environment(\.calendar) private var calendar

  var body: some View {
    VStack {
      MonthlyChartView(
        state: MonthlyChartState(
          calendar: calendar,
          entries: getData()))

      NetworthTabView()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
