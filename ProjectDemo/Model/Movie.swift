//
//  Movie.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 19/11/2022.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String
    let originCountry: [String]
    let originalName: String
    let name: String
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
}
