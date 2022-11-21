//
//  TVShowableViewDataSource.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//

import UIKit

enum TVShowTableViewDataSource: CaseIterable {
    typealias RawValue = Int
    
    static var allCases: [TVShowTableViewDataSource] {
        return [.topUp, .popular, .trending]
    }
    
    case topUp
    case popular
    case topRating
    case newMovie
    case trending
    
    func heightForRow() -> CGFloat {
        switch self {
        case .topUp:
            return 120
        case .popular:
            return 195
        case .newMovie:
            return 216
        case .topRating:
            return 146
        case .trending:
            return 158
        }
    }
    
    func typeOfCell() -> UITableViewCell.Type {
        switch self {
        case .topUp:
            return TVShowTopUpTableViewCell.self
        case .popular:
            return TVShowPopularTableViewCell.self
        case .newMovie:
            return NewMovieTableViewCell.self
        case .topRating:
            return TopRatingTableViewCell.self
        case .trending:
            return TrendingTableViewCell.self
        }
    }
    
    
    func titleOfHeader() -> String {
        switch self {
        case .topUp:
            return ""
        case .popular:
            return "Popular Movie"
        case .newMovie:
            return ""
        case .topRating:
            return "Top rating"
        case .trending:
            return "Trending"
        }
    }
}

