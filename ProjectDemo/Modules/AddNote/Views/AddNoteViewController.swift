//
//  AddNoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class AddNoteViewController: BaseViewController {

    @IBOutlet weak var bottomInsets: NSLayoutConstraint!
    @IBOutlet weak var lbSliderValue: UILabel!
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var filmNoteView: FilmNoteView!
    @IBOutlet weak var viewChooseMovie: UIView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var imageStackView: ImageStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    var isChooseMovie: Bool = false
    // MARK: - Properties
	var presenter: AddNotePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        configLabelRate()
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }
    
    func configLabelRate() {
        let value = Double(slider.value.first!).roundToPlaces(places: 1)
        lbSliderValue.text = "\(value)"
    }
    
    func configView() {
        filmNoteView.viewRating.isHidden = true
        filmNoteView.viewDate.isHidden = true
        filmNoteView.viewVoteAvg.isHidden = true
        filmNoteView.viewDate.isHidden = true
        filmNoteView.icProperties.image = UIImage(named: "ic_changeMovie")
        filmNoteView.lbProperties.text = "Change movie"
        if let movieDetail = self.movieDetail {
            filmNoteView.lbTitle.text = movieDetail.originalTitle
            filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(movieDetail.genres.map({$0.id}))
            filmNoteView.img.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movieDetail.posterPath)"))
            viewChooseMovie.isHidden = true
        } else if let review = self.review {
            slider.isSettingValue = true
            slider.value = [review.authorDetails!.rating]
            filmNoteView.lbTitle.text = review.originalTitle
            filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(Array(review.genreIDS))
            filmNoteView.img.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(review.posterPath)"))
            tfTitle.text = review.author
            textViewContent.text = review.content
            viewChooseMovie.isHidden = true
        } else {
            filmNoteView.isHidden = true
        }
        textViewContent.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.lbTitle.text = "Add Note"
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
        slider.snapStepSize = 0.1
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        self.view.addTapGestureRecognizer {
            self.view.endEditing(true)
        }
        configLabelRate()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        guard let name = tfTitle.text, let content = textViewContent.text else {
            return
        }
        if let movieDetail = movieDetail{
            let rating = Double(lbSliderValue.text.isNil(value: "0.0"))
            let object = ReviewsResultObject()
            object.originalName = movieDetail.originalName
            object.originalTitle = movieDetail.originalTitle
            object._id = movieDetail.id
            object.posterPath = movieDetail.posterPath
            object.backdropPath = movieDetail.backdropPath
            object.genreIDS.append(objectsIn: movieDetail.genres.map({$0.id}))
            object.content = content
            object.author = name
            object.createdAt = Date().toString()
            object.updatedAt = Date().toString()
            let authorDetails = AuthorDetailsObject()
            authorDetails.rating = rating!
            object.authorDetails = authorDetails
            presenter.didTapDone(object)
        } else if let review = review {
            let rating = Double(lbSliderValue.text.isNil(value: "0.0"))
            let object = ReviewsResultObject()
            object.originalName = review.originalName
            object.originalTitle = review.originalTitle
            object._id = review._id
            object.posterPath = review.posterPath
            object.backdropPath = review.backdropPath
            object.genreIDS.append(objectsIn: review.genreIDS)
            object.content = content
            object.author = name
            object.createdAt = Date().toString()
            object.updatedAt = Date().toString()
            let authorDetails = AuthorDetailsObject()
            authorDetails.rating = rating!
            object.authorDetails = authorDetails
            presenter.didTapDone(object)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageStackView.configView()
        viewChooseMovie.addDashedBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardEvents()
    }
}

// MARK: - AddNoteViewInterface
extension AddNoteViewController: AddNoteViewInterface {
    func didInsertReviewsResultObject() {
        self.navigationController?.popViewController(animated: true)
    }
    
    var movieDetail: MovieDetail? {
        if let movieDetail = self.payload as? MovieDetail {
            return movieDetail
        }
        return nil
    }
    
    var review: ReviewsResultObject? {
        if let review = self.payload as? ReviewsResultObject {
            return review
        }
        return nil
    }
}

extension AddNoteViewController: KeyboardDisplayableViewController {
    var scrollViewForResizeKeyboard: UIScrollView? {
        return scrollView
    }
}
