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
}

protocol StatisticcalPresenterInterface: PresenterInterface {
    func didTapSearch()
}

protocol StatisticcalInteractorInterface: InteractorInterface {
    func fetchWatchedListObjects()
}

protocol StatisticcalInteractorOutputInterface: InteractorOutputInterface {
    func fetchWatchedListObjects(_ objects: [WatchedListObject])
}

protocol StatisticcalWireframeInterface: WireframeInterface {
    func showSearchScreen()
}
