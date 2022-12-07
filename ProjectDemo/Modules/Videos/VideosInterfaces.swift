//
//  VideosInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 07/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol VideosViewInterface: ViewInterface {
}

protocol VideosPresenterInterface: PresenterInterface {
    func didTapPlayVideo(_ video: Video)
}

protocol VideosInteractorInterface: InteractorInterface {
}

protocol VideosInteractorOutputInterface: InteractorOutputInterface {
}

protocol VideosWireframeInterface: WireframeInterface {
}
