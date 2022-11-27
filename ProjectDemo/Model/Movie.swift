//
//  Movie.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 19/11/2022.
//

import Foundation
import RealmSwift

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init() {
        self.page = 0
        self.results = []
        self.totalPages = 0
        self.totalResults = 0
    }
}

// MARK: - Movie
struct Movie: Codable {
    var adult: Bool
    var backdropPath: String
    var genreIDS: [Int]
    var id: Int
    var originalLanguage, originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    var firstAirDate: String
    var originCountry: [String]
    var originalName: String
    var name: String
    var dateFavorite: String = ""
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video, name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate).isNil(value: "")
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult).isNil(value: false)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath).isNil(value: "")
        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS).isNil(value: [])
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage).isNil(value: "")
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle).isNil(value: "")
        overview = try values.decodeIfPresent(String.self, forKey: .overview).isNil(value: "")
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity).isNil(value: 0.0)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath).isNil(value: "")
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate).isNil(value: "")
        title = try values.decodeIfPresent(String.self, forKey: .title).isNil(value: "")
        video = try values.decodeIfPresent(Bool.self, forKey: .video).isNil(value: false)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage).isNil(value: 0.0)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount).isNil(value: 0)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry).isNil(value: [])
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
    }
    
    func toMovieObject() -> MovieObject {
        let object = MovieObject()
        object.adult = self.adult
        object._id = self.id
        object.backdropPath = self.backdropPath
        object.genreIDS.append(objectsIn: self.genreIDS)
        object.originalLanguage = self.originalLanguage
        object.originalTitle = self.originalTitle
        object.overview = self.overview
        object.popularity = self.popularity
        object.posterPath = self.posterPath
        object.releaseDate = self.releaseDate
        object.title = self.title
        object.video = self.video
        object.voteAverage = self.voteAverage
        object.voteCount = self.voteCount
        object.firstAirDate = self.firstAirDate
        object.originCountry.append(objectsIn: self.originCountry)
        object.originalName = self.originalName
        object.name = self.name
        object.dateFavorite = self.dateFavorite
        return object
    }
}

class MovieObject: Object {
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted (primaryKey: true) var _id: Int = 0
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var posterPath: String = ""
    @Persisted var releaseDate: String = ""
    @Persisted var title: String = ""
    @Persisted var video: Bool = false
    @Persisted var voteAverage: Double = 0.0
    @Persisted var voteCount: Int = 0
    @Persisted var firstAirDate: String = ""
    @Persisted var originCountry: List<String> = List<String>()
    @Persisted var originalName: String = ""
    @Persisted var name: String = ""
    @Persisted var dateFavorite: String = ""
}
