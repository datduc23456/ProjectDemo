//
//  MovieDetailObject.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 27/11/2022.
//

import Foundation
import RealmSwift


//let adult: Bool
//let backdropPath: String
//let createdBy: [Cast]
//let episodeRunTime: [Int]
//let firstAirDate: String
//let genres: [Genre]
//let homepage: String
//let id: Int
//let originalTitle: String
//let inProduction: Bool
//let languages: [String]
//let lastAirDate: String
//let lastEpisodeToAir: Episode
//let originalLanguage: String
//let name: String
//let nextEpisodeToAir: Episode
//let networks: [Network]
//let numberOfEpisodes, numberOfSeasons: Int
//let originCountry: [String]
//let originalName, overview: String
//let popularity: Double
//let posterPath: String
//let productionCompanies: [Network]
//let productionCountries: [Video]
//let seasons: [Season]
//let spokenLanguages: [SpokenLanguage]
//let status, tagline, type: String
//let voteAverage: Double
//let voteCount: Int
//let videos: Videos
//let title: String
//let recommendations: MovieResponse
//let reviews: Reviews
//let credits: Credits

class MovieDetailObject: Object {
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted (primaryKey: true) var _id: Int = 0
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var posterPath: String = ""
    @Persisted var lastAirDate: String = ""
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
    @Persisted var isTVShow: Bool = false
    @Persisted var isWatchedList: Bool = false
}

class CastObject: Object {
    @Persisted var adult: Bool = false
    @Persisted var gender: Int = 0
    @Persisted var castID: Int = 0
    @Persisted var creditID: Int = 0
    @Persisted var order: Int = 0
    @Persisted var id: Int = 0
    @Persisted var knownForDepartment: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted var profilePath: String = ""
    @Persisted var character: String = ""
    @Persisted var department: String = ""
    @Persisted var job: String = ""
    @Persisted var knownFor: KnowForObject?
    @Persisted var originalName: String = ""
    @Persisted var popularity: String = ""
    @Persisted var name: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var voteAverage: Double = 0.0
    @Persisted var releaseDate: String = ""
    @Persisted var title: String = ""
    @Persisted var firstAirDate: String = ""
}

class KnowForObject: Object {
    @Persisted var adult: Bool = false
    @Persisted var video: Bool = false
    @Persisted var id: Int = 0
    @Persisted var backdropPath: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted var mediaType: String = ""
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var voteAverage: Double = 0.0
    @Persisted var releaseDate: String = ""
    @Persisted var title: String = ""
    @Persisted var firstAirDate: String = ""
    @Persisted var name: String = ""
    @Persisted var originalName: String = ""
    @Persisted var originCountry: List<String> = List<String>()
}

class GenreObject: Object {
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
}

class EpisodeObject: Object {
    @Persisted var adult: Bool = false
    @Persisted var video: Bool = false
    @Persisted var id: Int = 0
    @Persisted var episodeNumber: Int = 0
    @Persisted var productionCode: String = ""
    @Persisted var mediaType: String = ""
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var voteAverage: Double = 0.0
    @Persisted var releaseDate: String = ""
    @Persisted var title: String = ""
    @Persisted var firstAirDate: String = ""
    @Persisted var name: String = ""
    @Persisted var stillPath: String = ""
    @Persisted var originCountry: List<String> = List<String>()
    @Persisted var runtime: Int = 0
    @Persisted var seasonNumber: Int = 0
    @Persisted var showID: Int = 0
    @Persisted var voteCount: Int = 0
}


class NetworkObject: Object {
    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var logoPath: String = ""
    @Persisted var originCountry: String = ""
}

class VideoObject: Object {
    @Persisted var iso639_1: String = ""
    @Persisted var name: String = ""
    @Persisted var iso3166_1: String = ""
    @Persisted var key: String = ""
    @Persisted var site: String = ""
    @Persisted var size: Int = 0
    @Persisted var type: String = ""
    @Persisted var official: Bool = false
    @Persisted var publishedAt: String = ""
    @Persisted var id: String = ""
}

class SeasonObject: Object {
    @Persisted var airDate: String = ""
    @Persisted var episodeCount: Int = 0
    @Persisted var id : Int = 0
    @Persisted var name: String = ""
    @Persisted var overview: String = ""
    @Persisted var posterPath: String = ""
    @Persisted var seasonNumber : Int = 0
}

class SearchKeyObject: Object {
    @Persisted var key: String = ""
}

class ReviewsResultObject: Object {
    @Persisted var author: String = ""
    @Persisted var authorDetails: AuthorDetailsObject?
    @Persisted var content: String = ""
    @Persisted var createdAt: String = ""
    @Persisted var updatedAt: String = ""
    @Persisted var url: String = ""
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted (primaryKey: true) var _id: Int = 0
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var posterPath: String = ""
    @Persisted var lastAirDate: String = ""
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
    @Persisted var isTVShow: Bool = false
    @Persisted var listImages: List<String> = List<String>()
}

class AuthorDetailsObject: Object {
    @Persisted var name: String = ""
    @Persisted var username: String = ""
    @Persisted var avatarPath: String = ""
    @Persisted var rating: Double = 0.0
}

class WatchedListObject: Object {
    @Persisted var author: String = ""
    @Persisted var authorDetails: AuthorDetailsObject?
    @Persisted var content: String = ""
    @Persisted var createdAt: String = ""
    @Persisted var updatedAt: String = ""
    @Persisted var url: String = ""
    @Persisted var adult: Bool = false
    @Persisted var backdropPath: String = ""
    @Persisted var genreIDS: List<Int> = List<Int>()
    @Persisted (primaryKey: true) var _id: Int = 0
    @Persisted var originalLanguage: String = ""
    @Persisted var originalTitle: String = ""
    @Persisted var overview: String = ""
    @Persisted var popularity: Double = 0.0
    @Persisted var posterPath: String = ""
    @Persisted var lastAirDate: String = ""
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
    @Persisted var runtime: Int = 0
    @Persisted var isTVShow: Bool = false
    @Persisted var listImages: List<String> = List<String>()
}
