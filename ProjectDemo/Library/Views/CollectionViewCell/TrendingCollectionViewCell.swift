//
//  TrendingCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TrendingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configCell(_ payload: Any) {
        if let payload = payload as? Movie {
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
        }
    }
    
}
