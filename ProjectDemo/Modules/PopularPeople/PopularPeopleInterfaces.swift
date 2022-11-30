//
//  PopularPeopleInterfaces.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol PopularPeopleViewInterface: ViewInterface {
    var id: Int { get }
    func getPeopleDetail(_ people: PeopleDetail)
    func getTopRate(_ response: MovieResponse)
}

protocol PopularPeoplePresenterInterface: PresenterInterface {
    func didTapPlayVideo(_ video: Video)
}

protocol PopularPeopleInteractorInterface: InteractorInterface {
    func getPeopleDetail(_ id: Int)
    func getTopRate()
}

protocol PopularPeopleInteractorOutputInterface: InteractorOutputInterface {
    func getPeopleDetail(_ people: PeopleDetail)
    func getTopRate(_ response: MovieResponse)
}

protocol PopularPeopleWireframeInterface: WireframeInterface {
}
