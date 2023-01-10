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

final class StatisticcalViewController: BaseViewController, AxisValueFormatter {
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
    @IBOutlet weak var icArrowWeek: UIImageView!
    var yearPicker: MIDatePicker?
    var monthPicker: MIDatePicker?
    var weekPicker: MIDatePicker?
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
        let range = calendar.range(of: .weekdayOrdinal, in: .month, for: date)!
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
        self.lbYear.text = "\(years.last!)"
        self.yearPicker = MIDatePicker.getFromNib()
        self.monthPicker = MIDatePicker.getFromNib()
        self.weekPicker = MIDatePicker.getFromNib()
        self.yearPicker?.delegate = self
        self.monthPicker?.delegate = self
        self.weekPicker?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        presenter.viewWillAppear(animated)
        self.yearPicker?.config.bouncingOffset = -AppDelegate.shared.appRootViewController.customTabbarHeight
        self.monthPicker?.config.bouncingOffset = -AppDelegate.shared.appRootViewController.customTabbarHeight
        self.weekPicker?.config.bouncingOffset = -AppDelegate.shared.appRootViewController.customTabbarHeight
        self.yearPicker?.selectedValue = years.count - 1
        self.yearPicker?.config.datePickerType = .year
        self.monthPicker?.config.datePickerType = .month
        self.weekPicker?.config.datePickerType = .week(year: yearSelected, month: monthSelected)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLayout {
            viewChart.roundCorners(corners: [.topRight, .bottomLeft, .bottomRight], radius: 8, borderColor: UIColor(hex: "#3F4249"), borderWidth: 1)
            isFirstLayout = !isFirstLayout
        }
    }

    @IBAction func monthFilterAction(_ sender: Any) {
        self.monthPicker?.show(inVC: self)
    }
    
    @IBAction func weekFilterAction(_ sender: Any) {
        guard monthSelected != 0 else { return }
        self.weekPicker?.show(inVC: self)
    }
    
    @IBAction func yearFilterAction(_ sender: Any) {
        self.yearPicker?.show(inVC: self)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.payload = 0
        bottomSheet.bottomDataSource = StatisticalType.allCases.compactMap({ return .label(title: $0.title, isChoose: $0 == statisticalType)})
        self.present(self.bottomSheet, animated: true, completion: {
            self.bottomSheet.stackContent.delegate = self
        })
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
        case .day:
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
    
    func fetchData(_ data: [String: [WatchedListObject]]) {
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
            self.weekPicker?.config.datePickerType = .week(year: yearSelected, month: monthSelected)
            self.lbMonth.text = "Choose month"
            self.lbWeek.text = "Choose week"
            self.icArrowWeek.image = UIImage(named: "ic_arrow_white_0.3")
            self.lbWeek.textColor = UIColor.white.withAlphaComponent(0.3)
            self.chartType = .month
        case .month:
            self.lbMonth.text = CommonUtil.convertNumberMonthToText(value)
            self.monthSelected = value
            self.weekPicker?.config.datePickerType = .week(year: yearSelected, month: monthSelected)
            self.lbWeek.textColor = UIColor.white
            self.lbWeek.text = "Choose week"
            self.icArrowWeek.image = UIImage(named: "ic_arrow_white")
            self.chartType = .week
        case .week:
            self.lbWeek.text = "\(value)"
            self.weekSelected = value
            self.chartType = .day
        }
    }
}
