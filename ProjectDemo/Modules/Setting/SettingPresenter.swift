//
//  SettingPresenter.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 08/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class SettingPresenter {

    private weak var view: SettingViewInterface?
    private var interactor: SettingInteractorInterface
    private var wireframe: SettingWireframeInterface

    init(view: SettingViewInterface,
         interactor: SettingInteractorInterface,
         wireframe: SettingWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension SettingPresenter: SettingPresenterInterface {
}

extension SettingPresenter: SettingInteractorOutputInterface {

    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
