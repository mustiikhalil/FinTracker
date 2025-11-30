// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI
import UserInterface

struct NetworkChartView: View {
  @State private var viewModel: NetworkChartViewModel
  @Environment(\.calendar) private var calendar

  init() {
    viewModel = NetworkChartViewModel()
  }

  var body: some View {
    @Bindable var vm = viewModel

    VStack(alignment: .leading) {
      PickerView(selectedSegment: $vm.selectedSegment)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal)
        .padding(.bottom)

      MonthlyChartView(
        state: MonthlyChartState(
          calendar: calendar,
          entries: viewModel.entries))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}

struct PickerView: View {
  @Binding var selectedSegment: ChartSegments

  var body: some View {
    Picker(selection: $selectedSegment) {
      ForEach(ChartSegments.allCases) { segment in
        Text(segment.text)
      }
    } label: {
      Text("Period")
    }
    .pickerStyle(.menu)
  }
}

#Preview {
  NetworkChartView()
}
