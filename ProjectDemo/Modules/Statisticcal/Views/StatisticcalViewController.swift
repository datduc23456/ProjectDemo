//
//  StatisticcalViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import Charts

enum ChartValueType {
    case month
    case quartner
    case year
}

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
    let yearStart: Int = 2010
    var chartsLabelFont = UIFont.init(name: "NexaRegular", size: 12)!
    var chartType: ChartValueType = .month
	var presenter: StatisticcalPresenterInterface!
    let months = (1...12).map { Int($0) }
    let ySet = [40, 20, 23, 4, 1 ,0]
    var years = (2010...Int(CommonUtil.getYearFromDate(Date().toString()))!).map { Int($0) }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
//        self.view.backgroundColor = .white
//        viewChart.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8)
        slider.value = [0]
        slider.snapStepSize = 1
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged) // continuous changes
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        presenter.viewWillAppear(animated)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    func customizeChart(data: [Int : [WatchedListObject]]) {
        var dataEntries: [ChartDataEntry] = []
        var dataEmpty: [ChartDataEntry] = []
        switch chartType {
        case .month:
            
            for month in months {
                let value = Double((data[month]).isNil(value: []).count)
                let dataEntry = ChartDataEntry(x: Double(month), y: value)
//                if value == 0 {
                    dataEmpty.append(dataEntry)
//                } else
                if value != 0 {
                    dataEntries.append(dataEntry)
                }
            }
        default:
            for key in data.keys {
                let dataEntry = ChartDataEntry(x: Double(key), y: Double(data[key]!.count))
                dataEntries.append(dataEntry)
            }
        }
        
        for key in data.keys {
            let dataEntry = ChartDataEntry(x: Double(key), y: Double(data[key]!.count))
            dataEntries.append(dataEntry)
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
        lineChartView.xAxis.gridColor = UIColor.init(hexa: "#FFFCFC").withAlphaComponent(0.2)
        lineChartView.xAxis.gridLineDashLengths = [1]
        lineChartView.xAxis.gridLineWidth = 1
        lineChartView.xAxis.axisRange = 1
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.granularityEnabled = true
        lineChartView.xAxis.valueFormatter = self
        lineChartView.xAxis.yOffset = 20
        lineChartView.xAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.xAxis.labelFont = chartsLabelFont
        
        lineChartView.leftAxis.labelFont = chartsLabelFont
        lineChartView.leftAxis.labelTextColor = .white.withAlphaComponent(0.5)
        lineChartView.leftAxis.labelXOffset = 0
        lineChartView.leftAxis.axisLineColor = .clear
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
            case .year:
                return "\(value)"
            case .quartner:
                return "\(value)"
            }
        }
        return "\(Int(value))"
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        _ = yearStart + Int(slider.value.first!)
//        lineChartView.setVisibleXRangeMinimum(Double(1))
        lineChartView.moveViewToX(Double(2025))
        lineChartView.setNeedsLayout()
//        customizeChart(dataPoints: players, values: goals.map{ Double($0) })
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }
}

// MARK: - StatisticcalViewInterface
extension StatisticcalViewController: StatisticcalViewInterface {
    func fetchWatchedListObjects(_ objects: [WatchedListObject]) {
        
    }
    
    func fetchDataYear(_ data: [Int : [WatchedListObject]]) {
        customizeChart(data: data)
    }
    
}

extension StatisticcalViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}
