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
    }
    
    override func configCell(_ payload: Any) {
        if let payload = payload as? Movie {
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbTitle.text = payload.originalName
            lbVoteAvg.text = "\(payload.voteAverage)"
            lbYear.text = CommonUtil.getYearFromDate(payload.releaseDate)
            lbGenres.text = DTPBusiness.shared.mapToGenreName(payload.genreIDS)
        }
    }
    
    func configCell(_ payload: Any, isTVShow: Bool = true) {
        self.configCell(payload)
        if isTVShow {
            imgPlayTitle.isHidden = true
            viewNumber.isHidden = true
        } else {
            viewVoteAvg.isHidden = true
        }
    }
}
