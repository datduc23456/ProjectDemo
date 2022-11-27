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
        // Initialization code
    }
    
    override func configCell(_ payload: Any) {
        if let cast = payload as? Cast {
            img.kf.setImage(with: URL(string: "\(baseURLImage)\(cast.profilePath)"))
            lbName.text = cast.name
            lbDepartment.text = cast.knownForDepartment
        }
    }
}
