//
//  PopularPeoplePresenter.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

final class PopularPeoplePresenter {

    private weak var view: PopularPeopleViewInterface?
    private var interactor: PopularPeopleInteractorInterface
    private var wireframe: PopularPeopleWireframeInterface
    private var peopleDetail: PeopleDetail?
    
    init(view: PopularPeopleViewInterface,
         interactor: PopularPeopleInteractorInterface,
         wireframe: PopularPeopleWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension PopularPeoplePresenter: PopularPeoplePresenterInterface {
    func didTapImage() {
        if let imagePaths = peopleDetail?.images.profile.map({$0.filePath}) {
            wireframe.showImagesScreen(imagePaths)
        }
    }
    
    func didTapVideos() {
        
    }
    
    func didTapSimilar() {
        if let peopleDetail = peopleDetail {
            wireframe.showSimilarScreen(peopleDetail)
        }
    }
    
    func viewDidLoad() {
        interactor.getPeopleDetail(view!.id)
    }
    
    func didTapPlayVideo(_ video: Video) {
        wireframe.showPlayVideo(video.key, false)
    }
}

extension PopularPeoplePresenter: PopularPeopleInteractorOutputInterface {
    func getPeopleDetail(_ people: PeopleDetail) {
        self.peopleDetail = people
        view?.getPeopleDetail(people)
    }
    
    func getTopRate(_ response: MovieResponse) {
        view?.getTopRate(response)
    }
    
    func handleError(_ error: Error, _ completion: (() -> Void)?) {
        view?.hideLoading()
        wireframe.handleError(error, completion)
    }
}
