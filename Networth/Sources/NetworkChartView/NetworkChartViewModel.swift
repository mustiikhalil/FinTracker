// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI
import UserInterface

public nonisolated struct MonthlyData: ChartData {
  public let id: UUID = UUID()
  public let startDate: Date
  public let endDate: Date
  public let totalSum: Decimal
  public let pension: Decimal
  public let endOfMonthLeftOver: Decimal
}

enum ChartSegments: Identifiable, CaseIterable, Hashable {
  case sixMonths, sixYears, allTime

  var id: Self {
    self
  }

  var text: String {
    switch self {
    case .sixMonths:
      "Last 6 months"
    case .sixYears:
      "Last 6 years"
    case .allTime:
      "All time"
    }
  }
}

@Observable
public final class NetworkChartViewModel {
  private let _entries: Entries
  var selectedSegment: ChartSegments = .sixMonths

  var entries: [MonthlyData] {
    switch selectedSegment {
    case .sixMonths:
      return _entries.sixMonths
    case .sixYears:
      return _entries.sixYears
    case .allTime:
      return _entries.allTime
    }
  }

  public init() {
    let data = getData()
    _entries = Entries(
      sixMonths: Array(data.prefix(6)),
      sixYears: Array(data.prefix(72)),
      allTime: data)
  }

  private struct Entries {
    let sixMonths: [MonthlyData]
    let sixYears: [MonthlyData]
    let allTime: [MonthlyData]
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
