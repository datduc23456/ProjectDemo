//
//  CoreTargetType.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/11/2022.
//

import Foundation
import Moya

enum CoreTargetType: TargetType {
    
    case example
    case upload([String: Any])
    case download(url: String, fileName: String?)
    
    var baseURL: URL { return URL(string: "")! }
    
    var path: String {
        switch self {
        case .example:
            return ""
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .example, .download:
            return .get
        case .upload:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .example:
            return .requestPlain
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
