//
//  HeaderView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 17/11/2022.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func headerView(_ customHeader: UITableViewHeaderFooterView, didTapButtonInSection section: Int)
}

class HeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnSeeMore: UIButton!
    static let reuseIdentifier = "HeaderView"
    weak var delegate: HeaderViewDelegate?
    var sectionNumber: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnSeeMore.addTapGestureRecognizer {
            DTPBusiness.shared.numberTapSeemore += 1
            if DTPBusiness.shared.numberTapSeemore == 2 {
                AdMobManager.shared.show(key: "RewardAd")
                DTPBusiness.shared.numberTapSeemore = 0
            }
            self.delegate?.headerView(self, didTapButtonInSection: self.sectionNumber)
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        
    }
}
