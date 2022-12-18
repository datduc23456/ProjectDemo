//
//  File.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 29/11/2022.
//
import Foundation
import UIKit

enum PeopleTableViewDataSource: CaseIterable {
    typealias RawValue = Int
    
    static var allCases: [PeopleTableViewDataSource] {
        return [.overview, .videos, .images, .trending]
    }
    
    case overview
    case videos
    case images
    case trending
    case tvshow
    
    func heightForRow() -> CGFloat {
        switch self {
        case .overview:
            return 100
        case .videos:
            return 195
        case .tvshow:
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 270
            }
            return 195
        case .images:
            return 95
        case .trending:
            return 158
        }
    }
    
    func typeOfCell() -> UITableViewCell.Type {
        switch self {
        case .overview:
            return TextExpandTableViewCell.self
        case .videos:
            return MovieVideosTableViewCell.self
        case .tvshow:
            return MovieVideosTableViewCell.self
        case .images:
            return ImagesTableViewCell.self
        case .trending:
            return TrendingTableViewCell.self
        }
    }
    
    
    func titleOfHeader() -> String {
        switch self {
        case .videos:
            return "Videos"
        case .tvshow:
            return "TV Shows"
        case .images:
            return "Image"
        case .trending:
            return "You may also like..."
        default:
            return ""
        }
    }
}
