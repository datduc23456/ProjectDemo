//
//  ActorsCollectionViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 19/11/2022.
//

import UIKit

class ActorsCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var lbDepartment: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
    }
    
    override func configCell(_ payload: Any) {
        if let cast = payload as? Cast {
            self.payload = payload
            img.kf.setImage(with: URL(string: "\(baseURLImage)\(cast.profilePath)"), placeholder: UIImage.init(named: "avatar_default"))
            lbName.text = cast.name
            lbDepartment.text = cast.knownForDepartment
        }
    }
}
