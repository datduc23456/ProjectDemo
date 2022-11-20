//
//  BaseModel.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/11/2022.
//

import Foundation

struct EmptyDecodable: Decodable {}

protocol BaseModelProtocol: Decodable {
    var status : Int? { get set }
    var message : String? { get set }
    var message_code : String? { get set }
}

