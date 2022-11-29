//
//  NoteInterfaces.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

protocol NoteViewInterface: ViewInterface {
}

protocol NotePresenterInterface: PresenterInterface {
    func didTapAddNote()
}

protocol NoteInteractorInterface: InteractorInterface {
}

protocol NoteInteractorOutputInterface: InteractorOutputInterface {
}

protocol NoteWireframeInterface: WireframeInterface {
    func showAddNoteScreen()
}