//
//  BaseNavigator.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//

import UIKit
public protocol Screen {
    var path: String { get }
    var transition: NavigateTransions { get }
    func createViewController(_ payload: Any?) -> UIViewController
}

public enum NavigateTransions: String {
    case replace
    case push
    case present
}

enum AppScreens: String, Screen, CaseIterable {
    case example
    case home
    case tvShow
    case favorite
    case detail
    case statistical
    case addnote
    case popularpeople
    
    var path: String {
        return rawValue
    }
    
    var transition: NavigateTransions {
        switch self {
        default:
            return .push
        }
    }
    
    func createViewController(_ payload: Any? = nil) -> UIViewController {
        switch self {
        case .example:
            return ExampleWireframe.generateModule(payload)
        case .tvShow:
            return TVShowWireframe.generateModule(payload)
        case .favorite:
            return FavoriteWireframe.generateModule(payload)
        case .detail:
            return MovieDetailWireframe.generateModule(payload)
        case .statistical:
            return StatisticcalWireframe.generateModule(payload)
        case .addnote:
            return AddNoteWireframe.generateModule(payload)
        case .popularpeople:
            return ActionWireframe.generateModule(payload)
        case .home:
            return HomeWireframe.generateModule(payload)
        }
    }
}
