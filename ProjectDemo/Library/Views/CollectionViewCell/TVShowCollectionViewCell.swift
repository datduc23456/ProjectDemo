//
//  TVShowCollectionViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 19/11/2022.
//

import UIKit

class TVShowCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var viewVoteAvg: UIView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var icPlayRate: UIImageView!
    @IBOutlet weak var lbNumber: UILabel!
    @IBOutlet weak var viewNumber: UIView!
    @IBOutlet weak var imgPlayTitle: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewNumber.roundCorners(corners: [.bottomRight, .topLeft], radius: 8)
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
    }
    
    override func configCell(_ payload: Any) {
        if let payload = payload as? Movie {
            self.payload = payload
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.originalName
            lbVoteAvg.text = "\(payload.voteAverage)"
            lbYear.text = CommonUtil.getYearFromDate(payload.releaseDate)
            lbGenres.text = DTPBusiness.shared.mapToGenreName(payload.genreIDS)
        }
        if let payload = payload as? Season {
            self.payload = payload
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.name
            lbGenres.text = payload.airDate.toDateFormat(toFormat: "MMM dd, yyyy")
            lbNumber.text = "\(payload.seasonNumber)"
        }
    }
    
    func configCell(_ payload: Any, isTVShowDetail: Bool = true) {
        self.configCell(payload)
        if isTVShowDetail {
            viewVoteAvg.isHidden = true
        } else {
            imgPlayTitle.isHidden = true
            viewNumber.isHidden = true
        }
    }
}
