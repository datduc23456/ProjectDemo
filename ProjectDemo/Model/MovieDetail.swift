//
//  MovieDetail.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 26/11/2022.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let adult: Bool
    let backdropPath: String
    let createdBy: [Cast]
    let episodeRunTime: [Int]?
    let firstAirDate: String
    let genres: [Genre]
    let homepage: String
    let id: Int
    let originalTitle: String
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let lastEpisodeToAir: Episode
    let originalLanguage: String
    let name: String
    let nextEpisodeToAir: Episode
    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [Network]
    let productionCountries: [Video]
    let seasons: [Season]
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, type: String
    let voteAverage: Double
    let voteCount: Int
    let videos: Videos
    let title: String
    let recommendations: MovieResponse
    let reviews: Reviews
    let credits: Credits
    let releaseDate: String
    let runtime: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
        case title
        case recommendations
        case reviews
        case credits
        case releaseDate = "release_date"
        case runtime
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle).isNil(value: "")
        title = try values.decodeIfPresent(String.self, forKey: .title).isNil(value: "")
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate).isNil(value: "")
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult).isNil(value: false)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath).isNil(value: "")
        episodeRunTime = try values.decodeIfPresent([Int]?.self, forKey: .episodeRunTime) ?? nil
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage).isNil(value: "")
        createdBy = try values.decodeIfPresent([Cast].self, forKey: .createdBy).isNil(value: [])
        languages = try values.decodeIfPresent([String].self, forKey: .languages).isNil(value: [])
        overview = try values.decodeIfPresent(String.self, forKey: .overview).isNil(value: "")
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity).isNil(value: 0.0)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath).isNil(value: "")
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres).isNil(value: [])
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage).isNil(value: "")
        lastAirDate = try values.decodeIfPresent(String.self, forKey: .lastAirDate).isNil(value: "")
        inProduction = try values.decodeIfPresent(Bool.self, forKey: .inProduction).isNil(value: false)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage).isNil(value: 0.0)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount).isNil(value: 0)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry).isNil(value: [])
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        lastEpisodeToAir = try values.decodeIfPresent(Episode.self, forKey: .lastEpisodeToAir).isNil(value: Episode())
        nextEpisodeToAir = try values.decodeIfPresent(Episode.self, forKey: .nextEpisodeToAir).isNil(value: Episode())
        networks = try values.decodeIfPresent([Network].self, forKey: .networks).isNil(value: [])
        numberOfEpisodes = try values.decodeIfPresent(Int.self, forKey: .numberOfEpisodes).isNil(value: 0)
        numberOfSeasons = try values.decodeIfPresent(Int.self, forKey: .numberOfSeasons).isNil(value: 0)
        productionCompanies = try values.decodeIfPresent([Network].self, forKey: .productionCompanies).isNil(value: [])
        productionCountries = try values.decodeIfPresent([Video].self, forKey: .productionCountries).isNil(value: [])
        seasons = try values.decodeIfPresent([Season].self, forKey: .seasons).isNil(value: [])
        spokenLanguages = try values.decodeIfPresent([SpokenLanguage].self, forKey: .spokenLanguages).isNil(value: [])
        status = try values.decodeIfPresent(String.self, forKey: .status).isNil(value: "")
        tagline = try values.decodeIfPresent(String.self, forKey: .tagline).isNil(value: "")
        type = try values.decodeIfPresent(String.self, forKey: .type).isNil(value: "")
        videos = try values.decodeIfPresent(Videos.self, forKey: .videos).isNil(value: Videos())
        recommendations = try values.decodeIfPresent(MovieResponse.self, forKey: .recommendations).isNil(value: MovieResponse())
        reviews = try values.decodeIfPresent(Reviews.self, forKey: .reviews).isNil(value: Reviews())
        credits = try values.decodeIfPresent(Credits.self, forKey: .credits).isNil(value: Credits())
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate).isNil(value: "")
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime).isNil(value: 0)
    }
    
    func toMovieObject() -> MovieDetailObject {
        let object = MovieDetailObject()
        object._id = self.id
        object.originalTitle = self.originalTitle
        object.originalName = self.originalName
        object.genreIDS.append(objectsIn: self.genres.map({$0.id}))
        object.posterPath = self.posterPath
        object.voteAverage = self.voteAverage
        object.firstAirDate = self.firstAirDate
        object.releaseDate = self.releaseDate
        object.isTVShow = self.isTVShow()
        return object
    }
    
    func isTVShow() -> Bool {
        @OptionalUnwrap(defaultValue: [], self.episodeRunTime) var episodeRunTime
        if !episodeRunTime.isEmpty {
            return true
        }
        return false
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
    
    init() {
        self.englishName = ""
        self.iso639_1 = ""
        self.name = ""
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String
    let episodeNumber, id: Int
    let name, overview, productionCode: String
    let runtime, seasonNumber, showID: Int
    let stillPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airDate = try values.decodeIfPresent(String.self, forKey: .airDate).isNil(value: "")
        episodeNumber = try values.decodeIfPresent(Int.self, forKey: .episodeNumber).isNil(value: 0)
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        overview = try values.decodeIfPresent(String.self, forKey: .overview).isNil(value: "")
        productionCode = try values.decodeIfPresent(String.self, forKey: .productionCode).isNil(value: "")
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime).isNil(value: 0)
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber).isNil(value: 0)
        showID = try values.decodeIfPresent(Int.self, forKey: .showID).isNil(value: 0)
        stillPath = try values.decodeIfPresent(String.self, forKey: .stillPath).isNil(value: "")
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage).isNil(value: 0.0)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount).isNil(value: 0)
    }
    init() {
        self.airDate = ""
        self.name = ""
        self.overview = ""
        self.productionCode = ""
        self.stillPath = ""
        self.voteCount = 0
        self.episodeNumber = 0
        self.voteAverage = 0.0
        self.showID = 0
        self.seasonNumber = 0
        self.runtime = 0
        self.id = 0
    }
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let name: String
    let logoPath: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        logoPath = try values.decodeIfPresent(String.self, forKey: .logoPath).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        originCountry = try values.decodeIfPresent(String.self, forKey: .originCountry).isNil(value: "")
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
    }
}

// MARK: - Season
struct Season: Codable {
    let airDate: String
    let episodeCount, id: Int
    let name, overview: String
    let posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airDate = try values.decodeIfPresent(String.self, forKey: .airDate).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        overview = try values.decodeIfPresent(String.self, forKey: .overview).isNil(value: "")
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath).isNil(value: "")
        episodeCount = try values.decodeIfPresent(Int.self, forKey: .episodeCount).isNil(value: 0)
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber).isNil(value: 0)
    }
    
    init() {
        self.airDate = ""
        self.posterPath = ""
        self.overview = ""
        self.name = ""
        self.episodeCount = 0
        self.id = 0
        self.seasonNumber = 0
    }
}

// MARK: - Videos
struct Videos: Codable {
    let video: [Video]
    
    enum CodingKeys: String, CodingKey {
        case video = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        video = try values.decodeIfPresent([Video].self, forKey: .video).isNil(value: [])
    }
    
    init() {
        self.video = []
    }
}

// MARK: - Result
struct Video: Codable {
    var iso639_1: String = ""
    var iso3166_1: String = ""
    var name: String = ""
    var key: String = ""
    var site: String = ""
    var size: Int = 0
    var type: String = ""
    var official: Bool = false
    var publishedAt: String = ""
    var id: String = ""
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso639_1 = try values.decodeIfPresent(String.self, forKey: .iso639_1).isNil(value: "")
        iso3166_1 = try values.decodeIfPresent(String.self, forKey: .iso3166_1).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        key = try values.decodeIfPresent(String.self, forKey: .key).isNil(value: "")
        site = try values.decodeIfPresent(String.self, forKey: .site).isNil(value: "")
        size = try values.decodeIfPresent(Int.self, forKey: .size).isNil(value: 0)
        type = try values.decodeIfPresent(String.self, forKey: .type).isNil(value: "")
        official = try values.decodeIfPresent(Bool.self, forKey: .official).isNil(value: false)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt).isNil(value: "")
        id = try values.decodeIfPresent(String.self, forKey: .id).isNil(value: "")
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    let page: Int
    let results: [ReviewsResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = try values.decodeIfPresent(Int.self, forKey: .page).isNil(value: 0)
        results = try values.decodeIfPresent([ReviewsResult].self, forKey: .results).isNil(value: [])
        totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages).isNil(value: 0)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults).isNil(value: 0)
    }
    
    init() {
        self.page = 0
        self.results = []
        self.totalPages = 0
        self.totalResults = 0
    }
}

// MARK: - ReviewsResult
struct ReviewsResult: Codable {
    var author: String = ""
    var authorDetails: AuthorDetails = AuthorDetails()
    var content: String = ""
    var createdAt: String = ""
    var id: String = ""
    var updatedAt: String = ""
    var url: String = ""
    var images: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        author = try values.decodeIfPresent(String.self, forKey: .author).isNil(value: "")
        authorDetails = try values.decodeIfPresent(AuthorDetails.self, forKey: .authorDetails).isNil(value: AuthorDetails())
        content = try values.decodeIfPresent(String.self, forKey: .content).isNil(value: "")
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt).isNil(value: "")
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt).isNil(value: "")
        url = try values.decodeIfPresent(String.self, forKey: .url).isNil(value: "")
        id = try values.decodeIfPresent(String.self, forKey: .id).isNil(value: "")
    }
    
    init() {
        
    }
    
    mutating func cloneFromReviewsObject(_ object: ReviewsResultObject) {
        self.content = object.content
        self.id = "\(object._id)"
        self.updatedAt = object.updatedAt
        self.url = object.url
        self.author = object.author
        if let authorDetails = object.authorDetails {
            self.authorDetails.cloneFromAuthorDetailsObject(authorDetails)
        }
        self.images = Array(object.listImages)
    }
//    func toReviewsResultObject() -> ReviewsResultObject {
//        let object = ReviewsResultObject()
//        object.author = self.author
//        object.authorDetails = self.authorDetails.toAuthorDetailsObject()
//        object.content = self.content
//        object.createdAt = self.createdAt
//        object._id = self.id
//        object.updatedAt = self.updatedAt
//        object.url = self.url
//        return object
//    }
}


// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    var name, username: String
    var avatarPath: String
    var rating: Double

    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        username = try values.decodeIfPresent(String.self, forKey: .username).isNil(value: "")
        avatarPath = try values.decodeIfPresent(String.self, forKey: .avatarPath).isNil(value: "")
        rating = try values.decodeIfPresent(Double.self, forKey: .rating).isNil(value: 0.0)
    }
    
    init() {
        self.name = ""
        self.username = ""
        self.avatarPath = ""
        self.rating = 0.0
    }
    
    func toAuthorDetailsObject() -> AuthorDetailsObject {
        let object = AuthorDetailsObject()
        object.avatarPath = self.avatarPath
        object.name = self.name
        object.username = self.username
        object.rating = self.rating
        return object
    }
    
    mutating func cloneFromAuthorDetailsObject(_ object: AuthorDetailsObject) {
        self.avatarPath = object.avatarPath
        self.name = object.name
        self.username = object.username
        self.rating = object.rating
    }
}

// MARK: - Credits
struct Credits: Codable {
    let cast, crew: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case cast, crew
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cast = try values.decodeIfPresent([Cast].self, forKey: .cast).isNil(value: [])
        crew = try values.decodeIfPresent([Cast].self, forKey: .crew).isNil(value: [])
    }
    
    init() {
        self.cast = []
        self.crew = []
    }
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String
    let knownFor: [KnownFor]
    let name, originalName: String
    let popularity: Double
    let profilePath: String
    let castID: Int
    let character: String
    let creditID: String
    let order: Int
    let department: String
    let job: String

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case knownFor = "known_for"
        case order, department, job
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult).isNil(value: false)
        gender = try values.decodeIfPresent(Int.self, forKey: .gender).isNil(value: 0)
        order = try values.decodeIfPresent(Int.self, forKey: .order).isNil(value: 0)
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName).isNil(value: "")
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath).isNil(value: "")
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity).isNil(value: 0.0)
        castID = try values.decodeIfPresent(Int.self, forKey: .castID).isNil(value: 0)
        character = try values.decodeIfPresent(String.self, forKey: .character).isNil(value: "")
        creditID = try values.decodeIfPresent(String.self, forKey: .creditID).isNil(value: "")
        department = try values.decodeIfPresent(String.self, forKey: .department).isNil(value: "")
        job = try values.decodeIfPresent(String.self, forKey: .job).isNil(value: "")
        knownFor = try values.decodeIfPresent([KnownFor].self, forKey: .knownFor).isNil(value: [])
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}
