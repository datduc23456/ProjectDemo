//
//  MovieDetailTableViewDataSource.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

enum MovieDetailTableViewDataSource: CaseIterable, Equatable {
    typealias RawValue = Int
    
    static var movieCases: [MovieDetailTableViewDataSource] {
        return [.actors, .overview, .videos, .images, .notes, .rate, .trending]
    }
    
    static var tvShowCases: [MovieDetailTableViewDataSource] {
        return [.actors, .overview, .season, .videos, .images, .notes, .rate]
    }
    
    case actors
    case overview
    case season
    case videos
    case images
    case notes
    case rate
    case trending
    
    func heightForRow() -> CGFloat {
        switch self {
        case .actors:
            return 90
        case .overview:
            return 100
        case .season:
            return 171
        case .videos:
            return 195
        case .images:
            return 95
        case .notes:
            return 157
        case .rate:
            return 157
        case .trending:
            return 158
        }
    }
    
    func typeOfCell() -> UITableViewCell.Type {
        switch self {
        case .actors:
            return ActorsTableViewCell.self
        case .overview:
            return TextExpandTableViewCell.self
        case .season:
            return TVShowPopularTableViewCell.self
        case .videos:
            return MovieVideosTableViewCell.self
        case .images:
            return ImagesTableViewCell.self
        case .notes:
            return NotesTableViewCell.self
        case .rate:
            return UserRateTableViewCell.self
        case .trending:
            return TrendingTableViewCell.self
        }
    }
    
    
    func titleOfHeader() -> String {
        switch self {
        case .season:
            return "Seasons"
        case .videos:
            return "Videos"
        case .images:
            return "Image"
        case .notes:
            return "Notes"
        case .trending:
            return "You may also like..."
        default:
            return ""
        }
    }
}
