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
    case week
    case day
}

enum StatisticalType: CaseIterable {
    case number
    case time
    case percent
    
    var title: String {
        switch self {
        case .number:
            return "Number of movies watched"
        case .time:
            return "Total time watched"
        case .percent:
            return "Percentage of movies watched"
        }
    }
}

final class StatisticcalViewController: BaseViewController, AxisValueFormatter, ValueFormatter {
    func stringForValue(_ value: Double, entry: Charts.ChartDataEntry, dataSetIndex: Int, viewPortHandler: Charts.ViewPortHandler?) -> String {
        return ""
    }
    
    // MARK: - Properties
    @IBOutlet weak var lbFilter: UILabel!
    @IBOutlet weak var lbMonth: UILabel!
    @IBOutlet weak var lbWeek: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var viewChart: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lineChartView: LineChartView!
    var datePicker: MIDatePicker?
    var presenter: StatisticcalPresenterInterface!
    let months = (1...12).map { Int($0) }
    let years = (2010...Int(CommonUtil.getYearFromDate(Date().toString()))!).map { Int($0) }
    let quartner = (1...4).map { Int($0) }
    var bottomSheet: BaseViewBottomSheetViewController!
    var yearSelected: Int = Int(CommonUtil.getYearFromDate(Date().toString()))!
    var monthSelected: Int = 0
    var weekSelected: Int = 0
    var weeks: [Int] {
        let dateComponents = DateComponents(year: yearSelected, month: monthSelected)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .weekOfMonth, in: .month, for: date)!
        return range.map { Int($0) }
    }
    
    var days = (1...7).map { Int($0) }
    var chartsLabelFont = UIFont.init(name: "NexaRegular", size: 12)!
    
    var statisticalType: StatisticalType = .number {
        didSet {
            lbFilter.text = statisticalType.title
            customizeChart(data: dataSource)
        }
    }
    var chartType: ChartValueType = .month {
        didSet {
            presenter.didChangeChargeType(chartType)
        }
    }
    var dataSource: [String: [WatchedListObject]] = [:] {
        didSet {
            tableView.reloadData()
            scrollView.isHidden = dataSource.isEmpty
            stackView.isHidden = !dataSource.isEmpty
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        tableView.registerCell(for: MyNoteTableViewCell.className)
        scrollView.showsVerticalScrollIndicator = false
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.sectionHeaderHeight = 0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            AdMobManager.shared.show(key: "InterstitialAd")
            self.presenter.didTapSearch()
        }
        navigation.imgSetting.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSetting()
        }
        navigation.lbTitle.text = "Statistical"
        navigation.configContentNav(.tabbar)
        self.datePicker = MIDatePicker.getFromNib()
        self.datePicker?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        presenter.viewWillAppear(animated)
        self.datePicker?.config.bouncingOffset = -AppDelegate.shared.appRootViewController.customTabbarHeight
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLayout {
            viewChart.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8, borderColor: UIColor(hex: "#3F4249"), borderWidth: 1)
            isFirstLayout = !isFirstLayout
        }
    }
    
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
            for year in dayForMonth {
                for key in data.keys {
                    if let value = data[key], Double(key) == Double(year) {
                        var yValue: Double = 0
                        switch statisticalType {
                        case .number:
                            yValue = Double(value.count)
                        case .time:
                            yValue = Double(value.map({$0.runtime / 60}).reduce(0, +))
                        case .percent:
                            yValue = Double(value.count)
                        }
                        let dataEntry = ChartDataEntry(x: Double(year), y: yValue)
                        dataEmpty.append(dataEntry)
                        dataEntries.append(dataEntry)
                    } else {
                        let dataEntry = ChartDataEntry(x: Double(year), y: 0)
                        dataEmpty.append(dataEntry)
                    }
                }
            }
        case .day:
            for quartner in quartner {
                for key in data.keys {
                    if let quart = key.components(separatedBy: " ").first, let quartInt = Int(quart) {
                        if let value = data[key], Double(quartInt) == Double(quartner) {
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
                let dataEntry = ChartDataEntry(x: Double(quartner), y: 0)
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
        lineChartView.xAxis.axisRange = 1
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
                return "\(value)"
            case .day:
                return "\(value)"
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
    
    @IBAction func monthFilterAction(_ sender: Any) {
        self.datePicker?.config.datePickerType = .month
        self.datePicker?.show(inVC: self)
    }
    
    @IBAction func weekFilterAction(_ sender: Any) {
        self.datePicker?.config.datePickerType = .week(year: yearSelected, month: monthSelected)
        self.datePicker?.show(inVC: self)
    }
    
    @IBAction func yearFilterAction(_ sender: Any) {
        self.datePicker?.config.datePickerType = .year
        self.datePicker?.show(inVC: self)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.payload = 0
        bottomSheet.bottomDataSource = StatisticalType.allCases.compactMap({ return .label(title: $0.title, isChoose: $0 == statisticalType)})
        //        delay(0.2, closure: {
        self.present(self.bottomSheet, animated: true, completion: {
            self.bottomSheet.stackContent.delegate = self
        })
//                })
        
        
    }
    
    @IBAction func addWatchedListAction(_ sender: Any) {
        presenter.didTapSearch()
    }
}

extension StatisticcalViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dataSource.keys)[section]
        return dataSource[key].isNil(value: []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyNoteTableViewCell.className, for: indexPath) as! MyNoteTableViewCell
        cell.selectionStyle = .none
        let key = Array(dataSource.keys)[indexPath.section]
        let watchList = dataSource[key].isNil(value: [])
        let object = watchList[indexPath.row]
        cell.configCell(object)
        cell.setupGradient()
        cell.didTapRemove = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.bottomSheet = BaseViewBottomSheetViewController()
                self.bottomSheet.bottomDataSource = [.content(title: "Remove watched list", content: "Are you sure you would like to remove this film from the watched list"), .button(title: "Remove", isPrimary: true), .button(title: "No, Thank", isPrimary: false)]
                self.bottomSheet.payload = object
                self.present(self.bottomSheet, animated: true, completion: {
                    self.bottomSheet.stackContent.delegate = self
                })
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.className) as! HeaderView
        let key = Array(dataSource.keys)[section]
        headerView.contentView.backgroundColor = APP_COLOR
        var headerTitle = ""
        switch chartType {
        case .week:
            headerTitle = "Week \(key)"
        case .month:
            headerTitle = key.toDateFormat(toFormat: "MMM yyyy")
        default:
            headerTitle = "Quartner \(key)"
        }
        headerView.lbTitle.text = headerTitle
        headerView.lbTitle.font = UIFont(name: "Nexa-Bold", size: 14)
        headerView.lbTitle.textColor = .white.withAlphaComponent(0.5)
        headerView.btnSeeMore.isHidden = true
        return headerView
    }
}

// MARK: - StatisticcalViewInterface
extension StatisticcalViewController: StatisticcalViewInterface {
    func deleteWatchedListObject(_ object: WatchedListObject?) {
        
    }
    
    func fetchWatchedListObjects(_ objects: [WatchedListObject]) {
        
    }
    
    func fetchDataYear(_ data: [String: [WatchedListObject]]) {
        dataSource = data
        customizeChart(data: data)
    }
}

extension StatisticcalViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

extension StatisticcalViewController: BoottomSheetStackViewDelegate {
    func didSelect(_ bottomSheetStackView: BottomSheetStackView, selectedIndex index: Int) {
        if let _ = bottomSheet.payload as? Int {
            switch index {
            case 1:
                statisticalType = .number
            case 2:
                statisticalType = .time
            case 3:
                statisticalType = .percent
            default:
                break
            }
            self.bottomSheet.shouldDismissSheet()
        } else if let object = bottomSheet.payload as? WatchedListObject {
            switch index {
            case 2:
                presenter.didTapDeleteWatchListObject(object)
                self.bottomSheet.shouldDismissSheet()
            case 3:
                self.bottomSheet.shouldDismissSheet()
            default:
                break
            }
        }
    }
}

extension StatisticcalViewController: MIDatePickerDelegate {
    func miDatePicker(amDatePicker: MIDatePicker, didSelect value: Int, forType: DatePickerType) {
        switch forType {
        case .year:
            self.lbYear.text = "\(value)"
            self.yearSelected = value
            self.chartType = .month
        case .month:
            self.lbMonth.text = "\(value)"
            self.monthSelected = value
            self.chartType = .week
        case .week:
            self.lbWeek.text = "\(value)"
            self.weekSelected = value
            self.chartType = .day
        }
    }
    
    func miDatePicker(amDatePicker: MIDatePicker, didSelect date: NSDate) {
        
    }
    
    func miDatePickerDidCancelSelection(amDatePicker: MIDatePicker) {
        
    }
}
