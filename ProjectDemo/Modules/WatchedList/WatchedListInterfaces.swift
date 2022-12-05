//
//  WatchedListInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 04/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol WatchedListViewInterface: ViewInterface {
    var movieDetail: MovieDetail? { get }
}

protocol WatchedListPresenterInterface: PresenterInterface {
    func didTapDone(_ object: WatchedListObject)
}

protocol WatchedListInteractorInterface: InteractorInterface {
    func insertWatchedListObject(_ review: WatchedListObject)
}

protocol WatchedListInteractorOutputInterface: InteractorOutputInterface {
}

protocol WatchedListWireframeInterface: WireframeInterface {
}
