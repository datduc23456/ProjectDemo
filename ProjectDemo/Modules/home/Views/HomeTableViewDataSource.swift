//
//  TableViewItem.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 18/11/2022.
//

import UIKit

enum HomeTableViewDataSource: CaseIterable {
    typealias RawValue = Int
    
    static var allCases: [HomeTableViewDataSource] {
        return [genges, pageView, popular, .newMovie, topRating, trending]
    }
    
    case genges
    case pageView
    case popular
    case topRating
    case newMovie
    case trending
    
    func heightForRow() -> CGFloat {
        switch self {
        case .genges:
            return 32
        case .pageView:
            let scaleWidth = CommonUtil.SCREEN_WIDTH / 375
            return 361 * scaleWidth
        case .popular:
            return 212
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
        case .genges:
            return GengesListTableViewCell.self
        case .pageView:
            return PageCinemaTableViewCell.self
        case .popular:
            return CinemaPopularTableViewCell.self
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
        case .genges:
            return "Genres"
        case .pageView:
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
