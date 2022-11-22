//
//  MovieDetailTableViewDataSource.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

enum MovieDetailTableViewDataSource: CaseIterable {
    typealias RawValue = Int
    
    static var allCases: [MovieDetailTableViewDataSource] {
        return [.actors, .videos, .images, .notes, .rate, .trending]
    }
    
    case actors
    case videos
    case images
    case notes
    case rate
    case trending
    
    func heightForRow() -> CGFloat {
        switch self {
        case .actors:
            return 96
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
        case .videos:
            return MovieVideosTableViewCell.self
        case .images:
            return TrendingTableViewCell.self
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
