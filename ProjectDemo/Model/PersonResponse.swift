//
//  Person.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 27/11/2022.
//

import Foundation

class PersonResponse: Codable {
    let page: Int
    let results: [Cast]
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

// MARK: - KnownFor
struct KnownFor: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let mediaType: String
    let originalLanguage: String
    let originalTitle: String
    let overview, posterPath: String
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate, name: String
    let originCountry: [String]
    let originalName: String

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult).isNil(value: false)
        video = try values.decodeIfPresent(Bool.self, forKey: .video).isNil(value: false)
        genreIDS = try values.decodeIfPresent([Int].self, forKey: .genreIDS).isNil(value: [])
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType).isNil(value: "")
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath).isNil(value: "")
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName).isNil(value: "")
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage).isNil(value: "")
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage).isNil(value: 0.0)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount).isNil(value: 0)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle).isNil(value: "")
        overview = try values.decodeIfPresent(String.self, forKey: .overview).isNil(value: "")
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath).isNil(value: "")
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry).isNil(value: [])
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate).isNil(value: "")
        title = try values.decodeIfPresent(String.self, forKey: .title).isNil(value: "")
    }
}
