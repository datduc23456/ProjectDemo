//
//  TopRatingCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TopRatingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func configCell(_ payload: Any) {
        if let payload = payload as? Movie {
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.originalTitle
            lbVoteAvg.text = "\(payload.voteAverage)"
            lbGenres.text = payload.overview
            lbYear.text = CommonUtil.getYearFromDate(payload.releaseDate)
            lbRating.text = "\(DTPBusiness.shared.roundRating(Double(payload.voteCount))) rating"
        }
    }
}