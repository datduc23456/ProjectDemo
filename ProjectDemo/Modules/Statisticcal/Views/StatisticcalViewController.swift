//
//  StatisticcalViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import Charts

final class StatisticcalViewController: BaseViewController, AxisValueFormatter, ValueFormatter {
    func stringForValue(_ value: Double, entry: Charts.ChartDataEntry, dataSetIndex: Int, viewPortHandler: Charts.ViewPortHandler?) -> String {
        return "h"
    }
    

    // MARK: - Properties
    @IBOutlet weak var lineChartView: LineChartView!
	var presenter: StatisticcalPresenterInterface!
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    let ySet = [40, 100, 23, 4, 1 ,0]
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = .white
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = ChartDataEntry(x: values[i], y: Double(ySet[i]))
          dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
//        lineChartDataSet.valueFormatter = self
        lineChartDataSet.mode = .cubicBezier
//        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
//        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
//        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
//        , NSUIColor.init(hex: "#751F3F")
        //NSUIColor.init(hex: "#7D263F"),
//        lineChartDataSet.colors = [NSUIColor.init(hex: "#7D263F").withAlphaComponent(0), NSUIColor.init(hex: "#98403D"), NSUIColor.init(hex: "#953D3D").withAlphaComponent(0.9), NSUIColor.init(hex: "#751F3F").withAlphaComponent(0)]
//        lineChartDataSet.isDrawLineWithGradientEnabled = true
//        lineChartDataSet.gradientPositions = [0, 50, 100]
        lineChartDataSet.colors = [NSUIColor.init(hex: "#98403D")]
        lineChartDataSet.circleColors = [NSUIColor.init(hex: "#FB716E")]
        lineChartDataSet.circleHoleRadius = 5
        lineChartDataSet.lineWidth = 3
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.xAxis.gridColor = UIColor.init(hexa: "#FFFCFC").withAlphaComponent(0.2)
        lineChartView.xAxis.gridLineDashLengths = [2]
        lineChartView.xAxis.gridLineWidth = 1
        lineChartView.xAxis.axisRange = 4
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.yOffset = 10
        lineChartView.xAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.xAxis.labelFont = UIFont.init(name: "NexaRegular", size: 12)!
        
        lineChartView.leftAxis.labelFont = UIFont.init(name: "NexaRegular", size: 12)!
        lineChartView.leftAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.leftAxis.labelXOffset = 10
        lineChartView.leftAxis.axisLineColor = .clear
        lineChartView.leftAxis.valueFormatter = self
        lineChartView.leftAxis.axisLineWidth = 1
        lineChartView.leftAxis.axisRange = 2
        lineChartView.leftAxis.gridLineWidth = 0
        
        lineChartView.rightAxis.gridColor = .clear
        lineChartView.rightAxis.axisLineColor = .clear
        lineChartView.rightAxis.labelTextColor = .clear
        
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        lineChartView.gridBackgroundColor = .clear
        lineChartView.extraLeftOffset = 20
        lineChartView.extraBottomOffset = 20
        lineChartView.data = lineChartData
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))h"
    }
}

// MARK: - StatisticcalViewInterface
extension StatisticcalViewController: StatisticcalViewInterface {
}
