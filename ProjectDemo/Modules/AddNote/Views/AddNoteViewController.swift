//
//  AddNoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 24/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class AddNoteViewController: BaseViewController {

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
        if isChooseMovie {
            filmNoteView.isHidden = true
        } else {
            viewChooseMovie.isHidden = true
        }
        textViewContent.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
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
}
