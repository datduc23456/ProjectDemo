//
//  DTPBusiness.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 20/11/2022.
//

import Foundation

class DTPBusiness {
    static let shared = DTPBusiness()
    var listGenres: [Genre] = []
    var genreSelectedId: Int = 0
    
    func mapToGenreName(_ listGenreIds: [Int]) -> String {
        var listGenresFilter: [Genre] = []
        
        for id in listGenreIds {
            if let genre = listGenres.first(where: {$0.id == id}) {
                listGenresFilter.append(genre)
            }
        }
        
        return listGenresFilter.map { $0.name }.reduce("") { (result, next) -> String in
            if result.isEmpty {
                return next
            }
            return "\(result), \(next)"
        }
    }
    
    func roundRating(_ rating: Double) -> String {
        if rating < 1000 {
            return "\(rating)k"
        } else {
            let rounded = rating.rounded(toPlaces: 3)
            return "\(rounded)k"
        }
    }
}
