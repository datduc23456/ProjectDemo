//
//  SmallNativeAdTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 13/12/2022.
//

import UIKit

class SmallNativeAdTableViewCell: UITableViewCell {

    @IBOutlet weak var adView: SmallNativeAdView!
    override func awakeFromNib() {
        super.awakeFromNib()
        adView.register(id: "")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
