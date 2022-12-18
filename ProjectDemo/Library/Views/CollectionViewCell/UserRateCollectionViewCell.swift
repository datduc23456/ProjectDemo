//
//  UserRateCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class UserRateCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        if let review = payload as? ReviewsResult {
            lbVoteAvg.text = "\(review.authorDetails.rating.roundToPlaces(places: 1))"
            lbname.text = review.author
            lbContent.text = review.content
            imgAvatar.kf.setImage(with: URL(string: "\(baseURLImage)\(review.authorDetails.avatarPath)"), placeholder: UIImage(named: "ava_default"))
            //voteAverage.roundToPlaces(places: 1)
        }
    }
}
