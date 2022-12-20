//
//  UserRateCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class UserRateCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var imageStackView: ImageStackView!
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
            lbname.text = review.authorDetails.username.isEmpty ? "You" : review.authorDetails.username
            lbContent.text = review.content
            let urls = review.images.map({
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                return documents.appendingPathComponent($0)
            })
            imgAvatar.kf.setImage(with: URL(string: "\(baseURLImage)\(review.authorDetails.avatarPath)"), placeholder: UIImage(named: "ava_default"))
            imageStackView.configView(urls, selectedIndex: -1)
            //voteAverage.roundToPlaces(places: 1)
        }
    }
}
