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
        return "abc"
    }
    

    // MARK: - Properties
    @IBOutlet weak var lineChartView: LineChartView!
	var presenter: StatisticcalPresenterInterface!
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    let ySet = [40, 100, 23, 4, 1 ,0]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = ChartDataEntry(x: values[i], y: Double(ySet[i]))
          dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "abc")
        lineChartDataSet.valueFormatter = self
        lineChartDataSet.mode = .cubicBezier
        let gradientColors = [UIColor.cyan.cgColor, UIColor.clear.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
//        , NSUIColor.init(hex: "#751F3F")
        //NSUIColor.init(hex: "#7D263F"),
        lineChartDataSet.colors = [NSUIColor.init(hex: "#98403D"), NSUIColor.init(hex: "#953D3D")]
        lineChartDataSet.isDrawLineWithGradientEnabled = true
        lineChartDataSet.gradientPositions = [0, 40, 100, 40]
        lineChartDataSet.lineWidth = 3
        lineChartView.xAxis.axisLineColor = .red
//        lineChartView.line
//        lineChartView.xAxis.gridLineWidth 
//            .linearGradient(stops: [])
//        lineChartDataSet.a
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
//        lineChartData.x
//        lineChartView.renderer
//        DataRenderer
        lineChartView.data = lineChartData
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "abc"
    }
}

// MARK: - StatisticcalViewInterface
extension StatisticcalViewController: StatisticcalViewInterface {
}
