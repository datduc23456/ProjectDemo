//
//  SeasonInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol SeasonViewInterface: ViewInterface {
    var seasons: [Season] { get }
}

protocol SeasonPresenterInterface: PresenterInterface {
}

protocol SeasonInteractorInterface: InteractorInterface {
}

protocol SeasonInteractorOutputInterface: InteractorOutputInterface {
}

protocol SeasonWireframeInterface: WireframeInterface {
}
