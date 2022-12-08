//
//  StatisticcalInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 23/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol StatisticcalViewInterface: ViewInterface {
    func fetchWatchedListObjects(_ objects: [WatchedListObject])
    func fetchDataYear(_ data: [String: [WatchedListObject]])
    func deleteWatchedListObject(_ object: WatchedListObject?)
}

protocol StatisticcalPresenterInterface: PresenterInterface {
    func didTapSearch()
    func didTapSetting()
    func didTapDeleteWatchListObject(_ object: WatchedListObject)
    func didChangeChargeType(_ chartType: ChartValueType)
}

protocol StatisticcalInteractorInterface: InteractorInterface {
    func fetchWatchedListObjects()
    func deleteWatchedListObject(_ object: WatchedListObject)
}

protocol StatisticcalInteractorOutputInterface: InteractorOutputInterface {
    func fetchWatchedListObjects(_ objects: [WatchedListObject])
    func deleteWatchedListObject(_ object: WatchedListObject?)
}

protocol StatisticcalWireframeInterface: WireframeInterface {
    func showSearchScreen()
    func showSettingScreen()
}
