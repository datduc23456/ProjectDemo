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
        return ""
    }
    
    // MARK: - Properties
    @IBOutlet weak var viewChart: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    @IBOutlet weak var lineChartView: LineChartView!
    
    var chartsLabelFont = UIFont.init(name: "NexaRegular", size: 12)!
	var presenter: StatisticcalPresenterInterface!
    let players = ["Ozil", "Ramsey", "Laca", "Auba", "Xhaka", "Torreira"]
    let goals = [6, 8, 26, 30, 8, 10]
    let ySet = [40, 20, 23, 4, 1 ,0]
    let years = (2017...2100).map { Int($0) }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
//        self.view.backgroundColor = .white
        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        viewChart.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8)
        viewChart.layer.masksToBounds = true
//        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged) // continuous changes
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(years[i]))
          dataEntries.append(dataEntry)
        }
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.colors = [NSUIColor.init(hex: "#98403D")]
        lineChartDataSet.circleColors = [NSUIColor.init(hex: "#FB716E")]
        lineChartDataSet.circleHoleRadius = 5
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.drawIconsEnabled = false
        lineChartDataSet.lineWidth = 3
        lineChartView.xAxis.axisLineColor = .clear
        lineChartView.xAxis.gridColor = UIColor.init(hexa: "#FFFCFC").withAlphaComponent(0.2)
        lineChartView.xAxis.gridLineDashLengths = [2]
        lineChartView.xAxis.gridLineWidth = 1
        lineChartView.xAxis.axisRange = 4
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.valueFormatter = self
        lineChartView.xAxis.yOffset = 10
        lineChartView.xAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.xAxis.labelFont = chartsLabelFont
        
        lineChartView.leftAxis.labelFont = chartsLabelFont
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
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.extraBottomOffset = 20
        lineChartView.legend.enabled = false
        lineChartView.dragEnabled = true
        lineChartView.data = lineChartData
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return "\(Int(value))h"
    }
}

// MARK: - StatisticcalViewInterface
extension StatisticcalViewController: StatisticcalViewInterface {
}

extension StatisticcalViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}
