//
//  StatisticcalPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class StatisticcalPresenter {

    private weak var view: StatisticcalViewInterface?
    private var interactor: StatisticcalInteractorInterface
    private var wireframe: StatisticcalWireframeInterface
    private var watchedListObjects: [WatchedListObject] = []
    private var data: [String: [WatchedListObject]] = [:]
    private var chartType: ChartValueType = .month
    
    init(view: StatisticcalViewInterface,
         interactor: StatisticcalInteractorInterface,
         wireframe: StatisticcalWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension StatisticcalPresenter: StatisticcalPresenterInterface {
    func viewDidLoad() {
        
    }
    
    func didTapSearch() {
        wireframe.showSearchScreen()
    }
    
    func viewWillAppear(_ animated: Bool) {
        interactor.fetchWatchedListObjects()
    }
    
    func didTapDeleteWatchListObject(_ object: WatchedListObject) {
        interactor.deleteWatchedListObject(object)
    }
    
    func didChangeChargeType(_ chartType: ChartValueType) {
        self.chartType = chartType
        interactor.fetchWatchedListObjects()
    }
    
    func didTapSetting() {
        wireframe.showSettingScreen()
    }
}

extension StatisticcalPresenter: StatisticcalInteractorOutputInterface {
    func deleteWatchedListObject(_ object: WatchedListObject?) {
        view?.deleteWatchedListObject(object)
        interactor.fetchWatchedListObjects()
    }
    
    func fetchWatchedListObjects(_ objects: [WatchedListObject]) {
        watchedListObjects = objects
        switch chartType {
        case .week:
            data = Dictionary(grouping: watchedListObjects, by: {
                let week = CommonUtil.getWeekFromDate($0.createdAt)
                let monthYear = $0.createdAt.toDateFormat(toFormat: "M yyyy")
                return "\(week) \(monthYear)"
            })
            view?.fetchData(data)
        case .month:
            data = Dictionary(grouping: watchedListObjects, by: {
                return $0.createdAt.toDateFormat(toFormat: "MM yyyy") })
            view?.fetchData(data)
        case .day:
            data = Dictionary(grouping: watchedListObjects, by: { CommonUtil.getDayFromDate($0.createdAt) })
            view?.fetchData(data)
        }
        
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
