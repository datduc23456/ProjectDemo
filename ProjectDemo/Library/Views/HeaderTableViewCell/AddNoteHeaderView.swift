//
//  AddNoteHeaderView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 04/12/2022.
//

import UIKit

class AddNoteHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var adView: SmallNativeAdView!
    static let reuseIdentifier = "AddNoteHeaderView"
    weak var delegate: HeaderViewDelegate?
    var sectionNumber: Int = 0
    
    @IBAction func didTapButton(_ sender: Any) {
        delegate?.headerView(self, didTapButtonInSection: sectionNumber)
    }
}
