//
//  TVShowInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class TVShowInteractor {

    weak var output: TVShowInteractorOutputInterface?
}

extension TVShowInteractor: TVShowInteractorInterface {
}
