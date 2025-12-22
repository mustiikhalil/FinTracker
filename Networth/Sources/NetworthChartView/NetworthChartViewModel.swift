// Copyright Gwen aka Mustii for BuildSwift

import SwiftUI
import UserInterface

public nonisolated struct MonthlyData: ChartData {
  public let id: UUID = UUID()
  public let month: Date
  public let dateComponents: DateComponents
  public let sum: Decimal
  public let savings: Decimal
  public let retirement: Decimal

  init(
    calendar: Calendar,
    month: Date,
    sum: Decimal,
    savings: Decimal,
    retirement: Decimal
  ) {
    self.month = month
    self.sum = sum
    self.savings = savings
    self.retirement = retirement

    dateComponents = calendar.dateComponents([.year, .month], from: month)
  }
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
public final class NetworthChartViewModel {
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
  let values: [(Decimal, Decimal)] = [
    // networth, without pension
    (367_577.25, 147_454.25),
    (387_506.93, 161_329.93),
    (412_896.5066505, 188_241.5066505),
    (424_413.5066505, 190_506.5066505),
    (462_373.888935, 217_465.888935),
    (480_243.463708, 229_610.463708),
    (514_055.20998, 254_541.21),
    (535_980.064665, 276_466.064665),
    (549_979.9101415, 265_448.6001415),
    (543_279.9101415, 273_172.9101415),
    (606_157.17288075, 319_777.17288075),
    (645_601.48288075, 348_028.48288075),
    (808_490.23, 395_254.2288945),
    (817_738.29, 399_438.28749),
    (835_367.81, 422_131.81),
    (795_641.369888, 370_004.369888),
    (746_672.09515, 336_478.09515),
    (799_225.09515, 370_833.09515),
    (826_561.69, 384_034.69),
    (844_605.68976, 402_078.68976),
    (877_189.224512, 429_660.224512),
    (900_022.0545065, 435_578.0545065),
    (918_902.77528, 441_078.77528),
    (1_040_336.426495, 454_800.426495),
    (1_060_540.386495, 475_343.386495),
  ]

  let months = 1
  let calendar = Calendar.current
  var firstDate = Date()

  var array: [MonthlyData] = []

  for value in values.reversed() {
    array.append(
      MonthlyData(
        calendar: calendar,
        month: firstDate,
        sum: value.0,
        savings: value.1,
        retirement: value.0 - value.1
      )
    )

    firstDate = calendar.date(byAdding: .month, value: -months, to: firstDate)!
  }

  return array
}
