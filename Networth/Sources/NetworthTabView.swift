// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI

public struct NetworthTabView: View {
  public init() {}

  public var body: some View {
    NavigationStack {
      List {
        Section {
          NetworkChartView()
        }
        .listSectionMargins(.all, 0)
        .listSectionSeparator(.hidden)
        .listRowBackground(Color.black)

        Section {
          ForEach(1..<10) { i in
            Text("row \(i)")
          }
        }
      }
    }
  }
}

#Preview {
  NetworthTabView()
}
