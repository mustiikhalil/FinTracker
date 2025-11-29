// Copyright Gwen aka Mustii for BuildSwift

import Networth
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")

      NetworthTabView()
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
