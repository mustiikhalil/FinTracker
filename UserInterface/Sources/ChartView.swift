// Copyright Gwen aka Mustii for BuildSwift

import Charts
import SwiftUI


public nonisolated struct MonthlyData: ChartData {
  public let id: UUID = UUID()
  public let startDate: Date
  public let endDate: Date
  public let totalSum: Decimal
  public let pension: Decimal
  public let endOfMonthLeftOver: Decimal
}

public nonisolated protocol ChartData: Identifiable, Hashable, Sendable {
  var id: UUID { get }
  var startDate: Date { get }
  var endDate: Date { get }
  var totalSum: Decimal { get }
  var pension: Decimal { get }
  var endOfMonthLeftOver: Decimal { get }
}

public nonisolated struct MonthlyChartState<T: ChartData>: Hashable, Sendable {
  private let isMoreThanOneYear: Bool
  let entries: [T]

  public init(calendar: Calendar, entries: [T]) {
    self.entries = entries

    isMoreThanOneYear = if let first = entries.first, let last = entries.last {
      calendar.isAYearApart(from: first.startDate, to: last.endDate)
    } else {
      false
    }
  }

  var strideBy: Calendar.Component {
    isMoreThanOneYear ? .year : .month
  }

  var strideCount: Int {
    2
  }

  var formatBy: Date.FormatStyle {
    isMoreThanOneYear ? .dateTime.year() : .dateTime.month(.abbreviated)
  }
}

extension Calendar {
  nonisolated func isAYearApart(from lhs: Date, to rhs: Date) -> Bool {
    let components = dateComponents([.year], from: lhs, to: rhs)
    guard let year = components.year else { return false }
    return year >= 1
  }
}

public struct MonthlyChartView<T>: View where T: ChartData {
  private let state: MonthlyChartState<T>

  public init(state: MonthlyChartState<T>) {
    self.state = state
  }

  public var body: some View {
    #if os(macOS)
    InternalChartView(state: state)
      .frame(minWidth: 350, minHeight: 250)
      .padding(.top, 50)
      .padding()
    #else
    InternalChartView(state: state)
      .frame(height: 250, alignment: .leading)
    #endif
  }
}

fileprivate struct InternalChartView<T>: View where T: ChartData {
  let state: MonthlyChartState<T>
  @State private var selectedDate: Date? = nil
  @Environment(\.calendar) private var calendar

  var selectedData: T? {
    guard let selectedDate else { return nil }
    let first = state.entries.first(where: {
      $0.startDate < selectedDate && selectedDate <= $0.endDate
    })
    return first
  }

  var body: some View {
    Chart {
      ForEach(state.entries) { entry in
        LineMark(
          x: .value("Month", entry.endDate, unit: .month),
          y: .value("amount", entry.totalSum))
          .foregroundStyle(.purple)
      }
      .interpolationMethod(.catmullRom)

      if let selectedData {
        RuleMark(
          x: .value("Selected", selectedData.endDate, unit: .month))
          .foregroundStyle(Color.gray.opacity(0.12))
          .annotation(
            position: .top,
            spacing: 20,
            overflowResolution: .init(
              x: .fit(to: .chart),
              y: .disabled))
        {
          VStack {
            Text(
              selectedData.endDate
                .formatted(.dateTime.month(.abbreviated)))
              .font(.caption)
            Text(selectedData.totalSum.formatted(.currency(code: "SEK")))
          }
          .padding(6)
          .background(
            .gray.opacity(0.16),
            in: RoundedRectangle(cornerRadius: 4))
        }
      }
    }
    .chartYAxis {
      AxisMarks(
        values: .automatic(minimumStride: 3, desiredCount: 5))
      { _ in
        AxisValueLabel(
          format: Decimal.FormatStyle.number.notation(.compactName),
          anchor: .leading,
          offsetsMarks: false)
      }
    }
    .chartXAxis { [state] in
      AxisMarks(
        values: .stride(
          by: state.strideBy,
          count: state.strideCount,
          roundUpperBound: true))
      { _ in
        AxisTick()
        AxisGridLine(centered: true)
        AxisValueLabel(
          format: state.formatBy,
          centered: true)
      }
    }
    .chartXSelection(value: $selectedDate)
  }
}

public func getData() -> [MonthlyData] {
  let months = 20 * 12
  var array = [MonthlyData]()
  var firstDate = Calendar.current.date(
    byAdding: .month,
    value: -months,
    to: Date())!
  for i in 0..<months {
    let month = Double(i + 1) / 12
    let endDate = Calendar.current.date(
      byAdding: .month,
      value: 1,
      to: firstDate)!
    let rand = Double.random(in: 7...10)
    let sum = Decimal(1_000_000 * month / rand)
    array.append(
      MonthlyData(
        startDate: firstDate,
        endDate: endDate,
        totalSum: sum,
        pension: Decimal(47_000 / month),
        endOfMonthLeftOver: 53_000))
    firstDate = endDate
  }
  return array
}

#Preview {
  MonthlyChartView(
    state: MonthlyChartState(
      calendar: Calendar.current,
      entries: getData()))
}
