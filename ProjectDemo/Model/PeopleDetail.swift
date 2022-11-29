//
//  PeopleDetail.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 29/11/2022.
//

import Foundation

// MARK: - PeopleDetail
struct PeopleDetail: Codable {
    let adult: Bool
    let alsoKnownAs: [String]
    let biography, birthday: String
    let deathday: String
    let gender: Int
    let homepage: String
    let id: Int
    let imdbID, knownForDepartment, name, placeOfBirth: String
    let popularity: Double
    let profilePath: String
    let tvCredits: MovieCredits
    let movieCredits: MovieCredits
    let images: ProfileResponse
    
    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case tvCredits = "tv_credits"
        case movieCredits = "movie_credits"
        case images = "images"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult).isNil(value: false)
        alsoKnownAs = try values.decodeIfPresent([String].self, forKey: .alsoKnownAs).isNil(value: [])
        gender = try values.decodeIfPresent(Int.self, forKey: .gender).isNil(value: 0)
        id = try values.decodeIfPresent(Int.self, forKey: .id).isNil(value: 0)
        knownForDepartment = try values.decodeIfPresent(String.self, forKey: .knownForDepartment).isNil(value: "")
        name = try values.decodeIfPresent(String.self, forKey: .name).isNil(value: "")
        biography = try values.decodeIfPresent(String.self, forKey: .biography).isNil(value: "")
        profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath).isNil(value: "")
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity).isNil(value: 0.0)
        birthday = try values.decodeIfPresent(String.self, forKey: .birthday).isNil(value: "")
        deathday = try values.decodeIfPresent(String.self, forKey: .deathday).isNil(value: "")
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage).isNil(value: "")
        imdbID = try values.decodeIfPresent(String.self, forKey: .imdbID).isNil(value: "")
        placeOfBirth = try values.decodeIfPresent(String.self, forKey: .placeOfBirth).isNil(value: "")
        tvCredits = try values.decodeIfPresent(MovieCredits.self, forKey: .tvCredits).isNil(value: MovieCredits())
        movieCredits = try values.decodeIfPresent(MovieCredits.self, forKey: .movieCredits).isNil(value: MovieCredits())
        images = try values.decodeIfPresent(ProfileResponse.self, forKey: .images).isNil(value: ProfileResponse())
    }
}

struct MovieCredits: Codable {
    let cast: [Movie]
    let crew: [Movie]
    
    init() {
        self.cast = []
        self.crew = []
    }
}

struct ProfileResponse: Codable {
    let profile: [Profile]
    
    enum CodingKeys: String, CodingKey {
        case profile = "profiles"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        profile = try values.decodeIfPresent([Profile].self, forKey: .profile).isNil(value: [])
    }
    
    init() {
        self.profile = []
    }
}

struct Profile: Codable {
    let aspectRatio: Double
    let height: Int
    let iso639_1: String
    let filePath: String
    let voteAverage: Double
    let voteCount, width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage).isNil(value: 0.0)
        aspectRatio = try values.decodeIfPresent(Double.self, forKey: .aspectRatio).isNil(value: 0.0)
        filePath = try values.decodeIfPresent(String.self, forKey: .filePath).isNil(value: "")
        height = try values.decodeIfPresent(Int.self, forKey: .height).isNil(value: 0)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount).isNil(value: 0)
        width = try values.decodeIfPresent(Int.self, forKey: .width).isNil(value: 0)
        iso639_1 = try values.decodeIfPresent(String.self, forKey: .iso639_1).isNil(value: "")
    }
}
