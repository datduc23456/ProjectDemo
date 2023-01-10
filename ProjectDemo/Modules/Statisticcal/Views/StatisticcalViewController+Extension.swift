//
//  StatisticcalViewController+Extension.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 02/01/2023.
//

import Foundation
import Charts

extension StatisticcalViewController: ValueFormatter {
    func customizeChart(data: [String: [WatchedListObject]]) {
        var dataEntries: [ChartDataEntry] = []
        var dataEmpty: [ChartDataEntry] = []
        switch chartType {
        case .month:
            for month in months {
                let keys = data.keys.filter { Int(CommonUtil.getMonthFromDate($0, dateFormat: "MM yyyy")) == month }
                var value: [WatchedListObject] = []
                for key in keys {
                    value += data[key].isNil(value: [])
                }
                var yValue: Double = 0
                switch statisticalType {
                case .number:
                    yValue = Double(value.count)
                case .time:
                    yValue = Double(value.map({$0.runtime / 60}).reduce(0, +))
                case .percent:
                    yValue = Double(value.count)
                }
                
                let dataEntry = ChartDataEntry(x: Double(month), y: yValue)
                dataEmpty.append(dataEntry)
                if value.count != 0 {
                    dataEntries.append(dataEntry)
                }
            }
        case .week:
            for weekData in weeks {
                for key in data.keys {
                    print("key: \(key)")
                    let a = "\(monthSelected) \(yearSelected)"
                    print("weekData: \(a)")
                    if let value = data[key], key == "\(weekData) \(a)" {
                        
                        var yValue: Double = 0
                        switch statisticalType {
                        case .number:
                            yValue = Double(value.count)
                        case .time:
                            yValue = Double(value.map({$0.runtime / 60}).reduce(0, +))
                        case .percent:
                            yValue = Double(value.count)
                        }
                        let dataEntry = ChartDataEntry(x: Double(weekData), y: yValue)
                        dataEmpty.append(dataEntry)
                        dataEntries.append(dataEntry)
                    } else {
                        let dataEntry = ChartDataEntry(x: Double(weekData), y: 0)
                        dataEmpty.append(dataEntry)
                    }
                }
            }
        case .day:
            for day in days {
                for key in data.keys {
                    if let quart = key.components(separatedBy: " ").first, let quartInt = Int(quart) {
                        if let value = data[key], Double(quartInt) == Double(day) {
                            var yValue: Double = 0
                            switch statisticalType {
                            case .number:
                                yValue = Double(value.count)
                            case .time:
                                yValue = Double(value.map({$0.runtime / 60}).reduce(0, +))
                            case .percent:
                                yValue = Double(value.count)
                            }
                            let dataEntry = ChartDataEntry(x: Double(quartInt), y: yValue)
                            dataEmpty.append(dataEntry)
                            dataEntries.append(dataEntry)
                        }
                    }
                }
                let dataEntry = ChartDataEntry(x: Double(day), y: 0)
                dataEmpty.append(dataEntry)
            }
        }
        
        let lineChartDataSetEmpty = LineChartDataSet(entries: dataEmpty, label: "")
        lineChartDataSetEmpty.mode = .horizontalBezier
        lineChartDataSetEmpty.colors = [NSUIColor.init(hex: "#98403D")]
        lineChartDataSetEmpty.circleColors = [NSUIColor.clear]
        lineChartDataSetEmpty.circleHoleRadius = 0
        lineChartDataSetEmpty.drawValuesEnabled = false
        lineChartDataSetEmpty.drawIconsEnabled = false
        lineChartDataSetEmpty.lineWidth = 3
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.colors = [NSUIColor.init(hex: "#98403D")]
        lineChartDataSet.circleColors = [NSUIColor.init(hex: "#FB716E")]
        lineChartDataSet.circleHoleRadius = 5
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.drawIconsEnabled = false
        lineChartDataSet.lineWidth = 3
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.xAxis.gridColor = .white.withAlphaComponent(0.5)
        lineChartView.xAxis.gridLineDashLengths = [1]
        //        lineChartView.xAxis.axisMinimum = 1
        lineChartView.xAxis.gridLineWidth = 1
        lineChartView.xAxis.axisRange = 2
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.valueFormatter = self
        lineChartView.xAxis.yOffset = 20
        lineChartView.xAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.xAxis.labelFont = chartsLabelFont
        
        lineChartView.leftAxis.labelFont = chartsLabelFont
        lineChartView.leftAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.leftAxis.axisMinimum = 0
        lineChartView.leftAxis.labelXOffset = 0
        lineChartView.leftAxis.axisLineDashLengths = [1]
        lineChartView.leftAxis.axisLineColor = .white.withAlphaComponent(0.5)
        lineChartView.leftAxis.valueFormatter = self
        lineChartView.leftAxis.granularityEnabled = true
        lineChartView.leftAxis.axisLineWidth = 1
        lineChartView.leftAxis.axisRange = 2
        lineChartView.leftAxis.gridLineWidth = 0
        lineChartView.leftAxis.xOffset = 20
        
        lineChartView.rightAxis.gridColor = .clear
        lineChartView.rightAxis.axisLineColor = .clear
        lineChartView.rightAxis.labelTextColor = .clear
        
        let lineChartData = LineChartData(dataSets: [lineChartDataSetEmpty, lineChartDataSet])
        
        lineChartView.gridBackgroundColor = .clear
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.extraBottomOffset = 20
        lineChartView.legend.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.data = lineChartData
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if let _ = axis as? XAxis {
            let value = Int(value)
            switch chartType {
            case .month:
                let monthText = CommonUtil.convertNumberMonthToText(value)
                return "\(monthText)"
            case .week:
                return "Week \(value)"
            case .day:
                let dayText = CommonUtil.convertNumberDayToText(value)
                return "\(dayText)"
            }
        } else if let _ = axis as? YAxis {
            switch statisticalType {
            case .number:
                return "\(Int(value))"
            case .time:
                return "\(Int(value))h"
            case .percent:
                return "\(Int(value))%"
            }
        }
        return "\(Int(value))"
    }
    
}
