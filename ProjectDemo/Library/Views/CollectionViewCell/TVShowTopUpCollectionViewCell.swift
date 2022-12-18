//
//  TVShowTopUpCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//

import UIKit

class TVShowTopUpCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var icPlay: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        image.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
    }
    
    override func configCell(_ payload: Any, isNeedFixedLayoutForIPad: Bool = false) {
        if let payload = payload as? Movie {
            self.payload = payload
            image.kf.setImage(with: URL(string: "\(baseURLImage)\(payload.posterPath)"))
            lbName.text = payload.originalName
//            icPlay.text = payload.is
        }
    }
}
