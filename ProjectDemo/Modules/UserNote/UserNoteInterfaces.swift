//
//  UserNoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol UserNoteViewInterface: ViewInterface {
    var movieDetail: MovieDetail? { get }
}

protocol UserNotePresenterInterface: PresenterInterface {
}

protocol UserNoteInteractorInterface: InteractorInterface {
}

protocol UserNoteInteractorOutputInterface: InteractorOutputInterface {
}

protocol UserNoteWireframeInterface: WireframeInterface {
}
