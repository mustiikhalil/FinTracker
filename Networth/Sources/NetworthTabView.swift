// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI

public struct NetworthTabView: View {
  public init() {}

  public var body: some View {
    NavigationStack {
      VStack {
        List {
          Section {
            NetworkChartView()
          }
          .setupMarginLessSection()

          Section {
            ForEach(1..<10) { i in
              Text("row \(i)")
            }
          }
        }
      }
    }
  }
}

private extension View {
  func setupMarginLessSection() -> some View {
    #if os(macOS)
    self
    #else
    listSectionMargins(.all, 0)
      .listSectionSeparator(.hidden)
      .listRowBackground(Color.black)
    #endif
  }
}

#Preview {
  NetworthTabView()
}
