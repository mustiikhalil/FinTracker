//
//  ContentView.swift
//  FinTracker
//
//  Created by Gwen on 2025-11-29.
//

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
