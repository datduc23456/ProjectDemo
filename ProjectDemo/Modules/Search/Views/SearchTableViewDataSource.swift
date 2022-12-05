//
//  SearchTableViewDataSource.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 27/11/2022.
//

import Foundation
import UIKit

enum SearchViewDataSource: CaseIterable {
    typealias RawValue = Int
    
    static var allCases: [SearchViewDataSource] {
        return [.movie, .tvshow, .person]
    }
    
    static var emptyCases:  [SearchViewDataSource] {
        return [.genre, .recent]
    }
    
    case movie
    case tvshow
    case person
    case genre
    case recent
    
    func heightForRow() -> CGFloat {
        switch self {
        case .movie:
            return 240
        case .tvshow:
            return 195
        case .person:
            return 150
        case .recent:
            return 30
        case .genre:
            return UITableView.automaticDimension
        }
    }
    
    func typeOfCell() -> UITableViewCell.Type {
        switch self {
        case .movie:
            return CinemaPopularTableViewCell.self
        case .tvshow:
            return TVShowPopularTableViewCell.self
        case .person:
            return PeoplePopularTableViewCell.self
        case .genre:
            return GenresSearchTableViewCell.self
        case .recent:
            return SearchHistoryTableViewCell.self
        }
    }
    
    
    func titleOfHeader() -> String {
        switch self {
        case .movie:
            return "Movies"
        case .tvshow:
            return "TV Shows"
        case .person:
            return "Actor"
        case .genre:
            return "Suggest"
        case .recent:
            return "Recent"
        }
    }
}
