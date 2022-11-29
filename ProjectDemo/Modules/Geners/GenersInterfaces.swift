//
//  GenersInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol GenersViewInterface: ViewInterface {
}

protocol GenersPresenterInterface: PresenterInterface {
    func didTapGenres(_ genre: Genre)
}

protocol GenersInteractorInterface: InteractorInterface {
}

protocol GenersInteractorOutputInterface: InteractorOutputInterface {
}

protocol GenersWireframeInterface: WireframeInterface {
    func showActionScreen(_ type: ActionViewType)
}
