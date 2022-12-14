//
//  CinemaPopularCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit
import Kingfisher

class CinemaPopularCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var icFavorite: UIImageView!
    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                self.icFavorite.image = UIImage(named: "ic_heart_color")
            } else {
                self.icFavorite.image = UIImage(named: "ic_heart")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewFavorite.roundCorners(corners: [.bottomLeft, .topRight], radius: 8)
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
        
        self.viewFavorite.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload as? Movie else { return }
            self.isFavorite = !self.isFavorite
            self.didTapAction?((payload, self.isFavorite))
        })
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        if let payload = payload as? Movie {
            if isNeedFixedLayoutForIPad {
                imageHeight.constant = 310
            }
            self.payload = payload
            image.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.originalTitle.isEmpty ? payload.originalName : payload.originalTitle
            lbVoteAvg.text = "\(payload.voteAverage.roundToPlaces(places: 1))"
            lbYear.text = CommonUtil.getYearFromDate(payload.releaseDate)
            lbGenres.text = DTPBusiness.shared.mapToGenreName(payload.genreIDS)
        }
    }
}
