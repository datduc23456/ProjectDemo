//
//  WatchedListViewController.swift
//  ProjectDemo
//
//  Created by đạt on 04/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class WatchedListViewController: DynamicBottomSheetViewController, UITextViewDelegate {
    
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
        self.contentView.addSubview(scrollView)
        self.contentView.addSubview(stackViewButton)
        for constraint in self.scrollView.constraints {
            self.scrollView.removeConstraint(constraint)
        }
        self.scrollView.fillToSuperView()
        self.contentScrollView.fillToSuperView()
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 96, right: 0)
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
        filmNoteView.viewDate.isHidden = true
        filmNoteView.viewRemove.isHidden = true
        filmNoteView.viewRating.isHidden = true
        textViewContent.delegate = self
        textViewContent.isPlaceHolder = true
        tfTitle.delegate = self
        tfTitle.becomeFirstResponder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeKeyboardEvents()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
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
}

// MARK: - WatchedListViewInterface
extension WatchedListViewController: WatchedListViewInterface {
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
