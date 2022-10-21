//
//  ExampleInteractor.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class ExampleInteractor {

    weak var output: ExampleInteractorOutputInterface?
}

extension ExampleInteractor: ExampleInteractorInterface {
}
