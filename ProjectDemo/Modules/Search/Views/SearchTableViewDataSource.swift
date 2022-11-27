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
    
    case movie
    case tvshow
    case person
    
    func heightForRow() -> CGFloat {
        switch self {
        case .movie:
            return 212
        case .tvshow:
            return 195
        case .person:
            return 150
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
        }
    }
}
