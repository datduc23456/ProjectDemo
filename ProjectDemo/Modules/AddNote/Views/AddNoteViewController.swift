//
//  AddNoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class AddNoteViewController: BaseViewController {

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
        if isChooseMovie {
            filmNoteView.isHidden = true
        } else {
            viewChooseMovie.isHidden = true
        }
        textViewContent.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.lbTitle.text = "Add Note"
        navigation.configContentNav(.navigation)
        slider.snapStepSize = 0.1
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
//        slider.addTarget(self, action: #selector(sliderDragEnded(_:)), for: . touchUpInside) // sent when drag ends
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        let value = Double(slider.value.first!).roundToPlaces(places: 1)
        lbSliderValue.text = "\(value)"
        print("thumb \(slider.draggedThumbIndex) moved")
        print("now thumbs are at \(slider.value)") // e.g., [1.0, 4.5, 5.0]
    }
    
    func configView() {
        if let movieDetail = self.movieDetail {
            filmNoteView.viewRating.isHidden = true
            filmNoteView.viewDate.isHidden = true
            filmNoteView.viewVoteAvg.isHidden = true
            filmNoteView.viewDate.isHidden = true
            filmNoteView.icProperties.image = UIImage(named: "ic_changeMovie")
            filmNoteView.lbProperties.text = "Change movie"
            filmNoteView.lbTitle.text = movieDetail.originalTitle
            filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(movieDetail.genres.map({$0.id}))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageStackView.configView()
        viewChooseMovie.addDashedBorder()
    }
}

// MARK: - AddNoteViewInterface
extension AddNoteViewController: AddNoteViewInterface {
    var movieDetail: MovieDetail? {
        if let movieDetail = self.payload as? MovieDetail {
            return movieDetail
        }
        return nil
    }
}
