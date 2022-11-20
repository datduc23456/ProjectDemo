//
//  CoreTargetType.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/11/2022.
//

import Foundation
import Moya

enum CoreTargetType: TargetType {
    case movieTopRated
    case nowPlaying
    case popular
    case detail(Int)
    case genreId(genreId: Int)
    case genreList
    case searchMovie(query: String, page: Int)
    case TVshowPopular(page: Int)
    case TVshowTopRate(page: Int)
    case TVshowLastest(page: Int)
    case TVshowDetail
    case searchTVshow(query: String, page: Int)
    case personPopular(page: Int)
    case personDetail(personId: Int)
    case searchPerson(query: String, page: Int)
    case upload([String: Any])
    case download(url: String, fileName: String?)
    
    var baseURL: URL { return URL(string: "https://api.themoviedb.org/3/")! }
    
    var path: String {
        switch self {
        case .movieTopRated:
            return "movie/top_rated"
        case .nowPlaying:
            return "movie/now_playing"
        case .popular:
            return "movie/popular"
        case .detail(let id):
            return "movie/\(id)"
        case .genreId:
            return "discover/movie"
        case .searchMovie:
            return "search/movie"
        case .TVshowPopular:
            return "tv/popular"
        case .TVshowTopRate:
            return "tv/top_rated"
        case .TVshowLastest:
            return "tv/airing_today"
        case .TVshowDetail:
            return "tv/100"
        case .searchTVshow:
            return "search/tv"
        case .personPopular:
            return "person/popular"
        case .personDetail(let personId):
            return "person/\(personId)"
        case .searchPerson:
            return "search/person"
        case .genreList:
            return "genre/movie/list"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .download:
            return .get
        case .upload:
            return .put
        default:
            return .get
        }
    }
    
    var params: [String : Any] {
        var defaultParams: [String: Any] = ["api_key": "63cbd7bb8ca53a31817a418b2cfb7e6a", "language": "en-US"]
        switch self {
        case .popular:
            defaultParams.updateValue("1", forKey: "page")
        case .detail:
            defaultParams.updateValue("videos,credits,recommendations,reviews", forKey: "append_to_response")
        case .genreId(let genreId):
            defaultParams.updateValue(genreId, forKey: "with_genres")
        case .searchMovie(let query, let page):
            defaultParams.updateValue(query, forKey: "query")
            defaultParams.updateValue(page, forKey: "page")
        case .TVshowPopular(let page):
            defaultParams.updateValue(page, forKey: "page")
        case .TVshowTopRate(let page):
            defaultParams.updateValue(page, forKey: "page")
        case .TVshowLastest(let page):
            defaultParams.updateValue(page, forKey: "page")
        case .TVshowDetail:
            defaultParams.updateValue("videos", forKey: "append_to_response")
        case .searchTVshow(let query, let page):
            defaultParams.updateValue(query, forKey: "query")
            defaultParams.updateValue(page, forKey: "page")
        case .personPopular(let page):
            defaultParams.updateValue(page, forKey: "page")
        case .personDetail:
            defaultParams.updateValue("movie_credits,images,tv_credits", forKey: "append_to_response")
        case .searchPerson(let query, let page):
            defaultParams.updateValue(query, forKey: "query")
            defaultParams.updateValue(page, forKey: "page")
        default:
            break
        }
        return defaultParams
    }
    
    var task: Task {
        switch self {
        case .upload(let params):
            var formData = [MultipartFormData]()
            for (key, value) in params {
                if let img = value as? UIImage {
                    let imgData = img.jpegData(compressionQuality: 0.5)!
                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "testImage.jpg", mimeType: "image/jpeg"))
                } else if let imgData = value as? Data {
                    formData.append(MultipartFormData(provider: .data(imgData), name: key, fileName: "testImage.jpg", mimeType: "image/jpeg"))
                } else {
                    formData.append(MultipartFormData(provider: .data("\(value)".data(using: .utf8)!), name: key))
                }
            }
            return .uploadMultipart(formData)
        case .download(_, _):
            return .downloadDestination(downloadDestination)
        default:
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    var localLocation: URL {
        switch self {
        case .download(let url, let fileName):
            let fileKey: String = url.md5
            let directory: URL = FileSystem.downloadDirectory
            var fileURL = directory.appendingPathComponent(fileKey)
            if let name = fileName {
                let pathExtension: String = (name as NSString).pathExtension.lowercased()
                fileURL = fileURL.appendingPathExtension(pathExtension)
            }
            return fileURL
        default:
            return URL(string: "")!
        }
    }
    
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.localLocation, [.removePreviousFile, .createIntermediateDirectories]) }
    }
}

class FileSystem {
    static let documentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()
    
    static let cacheDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.endIndex - 1]
    }()

    static let downloadDirectory: URL = {
        let directory: URL = FileSystem.documentsDirectory.appendingPathComponent("/Download/")
        return directory
    }()
    
}
