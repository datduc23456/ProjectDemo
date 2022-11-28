//
//  AddNoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol AddNoteViewInterface: ViewInterface {
    var movieDetail: MovieDetail? { get }
}

protocol AddNotePresenterInterface: PresenterInterface {
}

protocol AddNoteInteractorInterface: InteractorInterface {
}

protocol AddNoteInteractorOutputInterface: InteractorOutputInterface {
}

protocol AddNoteWireframeInterface: WireframeInterface {
}
