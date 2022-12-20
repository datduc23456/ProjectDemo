//
//  AddNoteHeaderView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 04/12/2022.
//

import UIKit

class AddNoteHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var adView: SmallNativeAdView!
    @IBOutlet weak var btnAddNote: UIButton!
    static let reuseIdentifier = "AddNoteHeaderView"
    weak var delegate: HeaderViewDelegate?
    var sectionNumber: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        adView.register(id: "ca-app-pub-3940256099942544/3986624511")
        btnAddNote.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.delegate?.headerView(self, didTapButtonInSection: self.sectionNumber)
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
    }
}
