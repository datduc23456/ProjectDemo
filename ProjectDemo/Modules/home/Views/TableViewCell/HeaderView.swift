//
//  HeaderView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 17/11/2022.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int)
}

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lbTitle: UILabel!
    static let reuseIdentifier = "HeaderView"
    weak var delegate: HeaderViewDelegate?
    var sectionNumber: Int!
    
    @IBAction func didTapButton(_ sender: Any) {
        delegate?.headerView(self, didTapButtonInSection: sectionNumber)
    }
}
