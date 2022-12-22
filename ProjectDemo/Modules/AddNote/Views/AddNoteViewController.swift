//
//  AddNoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class AddNoteViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var viewToast: UIView!
    @IBOutlet weak var lbTextFieldPlaceHolder: UILabel!
    private var imagePicker = UIImagePickerController()
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
    var listImages: [String] = [] {
        didSet {
            loadImages()
        }
    }
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
    
    func configViewWithPayload() {
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
            tfTitle.text = ""
            viewChooseMovie.isHidden = true
            filmNoteView.isHidden = false
        } else if let review = self.review {
            slider.value = [review.authorDetails!.rating]
            filmNoteView.lbTitle.text = review.originalTitle
            filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(Array(review.genreIDS))
            filmNoteView.img.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(review.posterPath)"))
            tfTitle.text = review.author
            listImages = Array(review.listImages)
            lbTextFieldPlaceHolder.isHidden = true
            textViewContent.text = review.content
            textViewContent.textColor = UIColor(hex: "#FFFFFF")
            textViewContent.isPlaceHolder = false
            viewChooseMovie.isHidden = true
            filmNoteView.isHidden = false
        } else {
            filmNoteView.isHidden = true
        }
        filmNoteView.btnProperties.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didChangeMovie()
        }
        configLabelRate()
    }
    
    func configView() {
        textViewContent.textColor = UIColor(hex: "#FFFFFF").withAlphaComponent(0.5)
        textViewContent.text = "Type here to add review..."
        textViewContent.isPlaceHolder = true
        tfTitle.keyboardAppearance = .dark
        textViewContent.keyboardAppearance = .dark
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
        textViewContent.delegate = self
        imagePicker.delegate = self
        tfTitle.delegate = self

        tfTitle.becomeFirstResponder()
        imageStackView.didAdditionImage = {
            self.present(self.imagePicker, animated: true) {}
        }
        configViewWithPayload()
    }
    
    @IBAction func doneAction(_ sender: Any) {
        guard let name = tfTitle.text, let content = textViewContent.text, !name.isEmpty, !content.isEmpty else {
            return
        }
        if let movieDetail = movieDetail {
            let rating = Double(lbSliderValue.text.isNil(value: "0.0"))
            let object = ReviewsResultObject()
            object.originalName = movieDetail.originalName
            object.originalTitle = movieDetail.originalTitle
            object._id = UUID().uuidString
            object.movieId = movieDetail.id
            object.posterPath = movieDetail.posterPath
            object.backdropPath = movieDetail.backdropPath
            object.genreIDS.append(objectsIn: movieDetail.genres.map({$0.id}))
            object.content = content
            object.author = name
            object.createdAt = Date().timeIntervalSince1970.stringFromTimeInterval()
            object.updatedAt = Date().timeIntervalSince1970.stringFromTimeInterval()
            object.listImages.append(objectsIn: listImages)
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
            object.movieId = review.movieId
            object.content = content
            object.author = name
            object.createdAt = Date().timeIntervalSince1970.stringFromTimeInterval()
            object.updatedAt = Date().timeIntervalSince1970.stringFromTimeInterval()
            object.listImages.append(objectsIn: listImages)
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
        loadImages()
        viewChooseMovie.addDashedBorder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeKeyboardEvents()
    }
    
    @IBAction func searchAction(_ sender: Any) {
        presenter.didTapSearch()
    }
    
    fileprivate func loadImages() {
        let urls = listImages.map({
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return documents.appendingPathComponent($0)
        })
        imageStackView.configView(urls, selectedIndex: -1, isAdditionImage: true)
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

// MARK: - AddNoteViewInterface
extension AddNoteViewController: AddNoteViewInterface {
    func didInsertReviewsResultObject(_ review: ReviewsResultObject) {
        self.popChildViewController(review, true)
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

extension AddNoteViewController: BackFromNextHandleable {
    func onBackFromNext(_ result: Any?) {
        if let result = result as? MovieDetail {
            self.payload = result
            self.configViewWithPayload()
        }
    }
}

extension AddNoteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            if textField.text!.isEmpty {
                self.lbTextFieldPlaceHolder.isHidden = true
            }
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, animations: {
            if textField.text?.isEmpty == true {
                self.lbTextFieldPlaceHolder.isHidden = false
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension AddNoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self, let imageUrl = CommonUtil.saveImageFromPhotosToLocal(info: info) else { return }
                self.listImages.append(imageUrl)
            }
        }
        
        if #available(iOS 11.0, *) {
            if let imgURL = info[.imageURL] as? URL {
                print("imgURL: \(imgURL)")
            }
        } else {
            if let imgURL = info[.referenceURL] as? NSURL {
                print("imgURL: \(imgURL)")
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            
        }
    }
}
