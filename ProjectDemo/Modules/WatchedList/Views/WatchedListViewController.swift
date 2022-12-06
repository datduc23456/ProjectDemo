//
//  WatchedListViewController.swift
//  ProjectDemo
//
//  Created by đạt on 04/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class WatchedListViewController: DynamicBottomSheetViewController, UITextViewDelegate {
    
    @IBOutlet weak var lbQuestion: UILabel!
    @IBOutlet weak var lbToast: UILabel!
    @IBOutlet weak var viewToast: UIView!
    @IBOutlet weak var stackViewButton: UIStackView!
    @IBOutlet weak var lbTextFieldPlaceHolder: UILabel!
    @IBOutlet weak var lbSliderValue: UILabel!
    @IBOutlet weak var slider: MultiSlider!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var filmNoteView: FilmNoteView!
    @IBOutlet weak var contentScrollView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfContent: UITextField!
    @IBOutlet weak var imageStackView: ImageStackView!
    // MARK: - Properties
	var presenter: WatchedListPresenterInterface!

    override func configureView() {
        super.configureView()
        self.filmNoteView.viewRating.isHidden = true
        self.filmNoteView.viewDate.isHidden = true
        self.filmNoteView.viewRemove.isHidden = true
        self.contentView.addSubview(scrollView)
        self.contentView.addSubview(stackViewButton)
        self.contentView.addSubview(viewToast)
        self.viewToast.addSubview(lbToast)
        for constraint in self.scrollView.constraints {
            self.scrollView.removeConstraint(constraint)
        }
//        self.scrollView.fillToSuperView()
        self.contentScrollView.fillToSuperView()
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
        
        self.scrollView.snp.makeConstraints {
            $0.leading.equalTo(contentView)
            $0.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView)
            $0.top.equalTo(contentView)
        }
        
        self.contentScrollView.snp.makeConstraints {
            $0.width.equalTo(contentView)
            $0.height.equalTo(250).priority(250)
        }
        stackViewButton.snp.makeConstraints {
            $0.leading.equalTo(contentView)
            $0.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(96)
        }
        
        textViewContent.delegate = self
        textViewContent.isPlaceHolder = true
        tfTitle.delegate = self
        tfTitle.becomeFirstResponder()
        slider.snapStepSize = 0.1
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        self.view.addTapGestureRecognizer {
            self.view.endEditing(true)
        }
        self.scrollView.layoutIfNeeded()
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
        guard let movieDetail = movieDetail else { return }
        let movieName = !movieDetail.originalTitle.isEmpty ? movieDetail.originalTitle : movieDetail.originalName
        lbQuestion.text = "Do you want to add this \"\(movieName)\" movie to your watched list?"
        slider.value = [0.0]
        lbSliderValue.text = "0.0"
        tfTitle.text = ""
        textViewContent.text = ""
        filmNoteView.lbVoteAvg.text = "\(movieDetail.voteAverage.roundToPlaces(places: 1))"
        filmNoteView.lbYear.text = CommonUtil.getYearFromDate(!movieDetail.releaseDate.isEmpty ? movieDetail.releaseDate : movieDetail.firstAirDate)
        filmNoteView.lbTitle.text = movieName
        filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(movieDetail.genres.map({$0.id}))
        filmNoteView.img.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movieDetail.posterPath)"))
        DTPBusiness.shared.fetchWatchedListObjectWithId(movieDetail.id, completion: { [weak self] watched in
            guard let `self` = self, let watched = watched else { return }
            self.slider.value = [watched.authorDetails!.rating]
            self.tfTitle.text = watched.author
            self.textViewContent.text = watched.content
            self.configLabelRate()
        })
//        tfTitle.text = ""
//        textViewContent.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardEvents()
        configView()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        guard let name = tfTitle.text, let content = textViewContent.text, !name.isEmpty, !content.isEmpty else {
            self.showToastAlert()
            return
        }
        if let movieDetail = movieDetail {
            let rating = Double(lbSliderValue.text.isNil(value: "0.0"))
            let object = WatchedListObject()
            object.originalName = movieDetail.originalName
            object.originalTitle = movieDetail.originalTitle
            object._id = movieDetail.id
            object.posterPath = movieDetail.posterPath
            object.backdropPath = movieDetail.backdropPath
            object.genreIDS.append(objectsIn: movieDetail.genres.map({$0.id}))
            object.content = content
            object.author = name
            object.runtime = !(movieDetail.runtime == 0) ? movieDetail.runtime : movieDetail.episodeRunTime.isNil(value: []).reduce(0, +)
            object.createdAt = Date().toString()
            object.updatedAt = Date().toString()
            let authorDetails = AuthorDetailsObject()
            authorDetails.rating = rating!
            object.authorDetails = authorDetails
            presenter.didTapDone(object)
            self.dismiss(animated: true, completion: { [weak self] in
                guard let weakSelf = self else { return }
                if let current = weakSelf.currentViewController() {
                    weakSelf.setBackResultIfCan(vc: current, result: object)
                }
            })
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.isPlaceHolder.isNil(value: false) {
            textView.text = nil
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textView.textColor = UIColor(hex: "#FFFFFF")
        textView.isPlaceHolder = false
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.5)
            textView.text = "Type here to add review..."
            textView.isPlaceHolder = true
        }
    }
    
    func showToastAlert() {
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
            self.viewToast.alpha = 1
        }, completion: {_ in
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
                self.viewToast.alpha = 0
            })
        })
    }
}

// MARK: - WatchedListViewInterface
extension WatchedListViewController: WatchedListViewInterface {
    var movieDetail: MovieDetail? {
        if let movieDetail = self.payload as? MovieDetail {
            return movieDetail
        }
        return nil
    }
    
    func showLoading() {
        
    }
    
    func showLoading(message: String) {
        
    }
    
    func hideLoading() {
        
    }
    
}

extension WatchedListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            if textField.text!.isEmpty {
                self.lbTextFieldPlaceHolder.isHidden = true
            }
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            self.lbTextFieldPlaceHolder.isHidden = false
        })
    }
}

extension WatchedListViewController: KeyboardDisplayableViewController {
    var scrollViewForResizeKeyboard: UIScrollView? {
        return scrollView
    }
}

extension WatchedListViewController {
    func setBackResultIfCan(vc: UIViewController, result: Any?) {
        guard let backFromNextHandleable = vc as? BackFromNextHandleable else {
            return
        }
        backFromNextHandleable.onBackFromNext(result)
    }
    
    func currentViewController(from: UIViewController? = nil) -> UIViewController? {
        if let from = from {
            if let presented = from.presentedViewController {
                return currentViewController(from: presented)
            }
            if let nav = from as? UINavigationController {
                if let last = nav.children.last {
                    return currentViewController(from: last)
                }
                return nav
            }
            if let tab = from as? UITabBarController {
                if let selected = tab.selectedViewController {
                    return currentViewController(from: selected)
                }
                return tab
            }
            return from
        } else if let presented = presentedViewController {
            return currentViewController(from: presented)
        } else {
            let rootViewController = AppDelegate.shared.navigationRootViewController
            return currentViewController(from: rootViewController)
        }
    }
}
