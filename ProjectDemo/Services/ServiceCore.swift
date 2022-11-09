//
//  ServiceCore.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/11/2022.
//

import Foundation
import Moya

enum NetworkError: Error {
    case objectMapping
    case httpCodeNotValid
}

final class ServiceCore {
    static func request<D: Decodable, T: TargetType>(_ type: D.Type,
                                                     targetType: T,
                                                     successBlock: @escaping ((D)->Void),
                                                     failureBlock: @escaping ((MoyaError)->Void)) {
        let provider = MoyaProvider<T>()
        provider.request(targetType, completion: { result in
            switch result {
            case .success(let response):
                if response.statusCode == 200 {
                    let data = response.data
                    if let responseModel = data.tranforms(to: D.self) {
                        successBlock(responseModel)
                    } else {
                        failureBlock(MoyaError.objectMapping(NetworkError.objectMapping, response))
                    }
                } else {
                    failureBlock(MoyaError.statusCode(response))
                }
            case .failure(let error):
                failureBlock(error)
                debugPrint(error.errorDescription.isNil(value: ""))
            }
        })
    }
}
