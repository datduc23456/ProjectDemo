//
//  TVShowTopUpTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//

import UIKit

class TVShowTopUpTableViewCell: BaseWithCollectionTableViewCell<TVShowTopUpCollectionViewCell, Movie> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 120, height: 120), minimumInteritemSpacing: 0, minimumLineSpacing: 12, footerReferenceSize: CGSize(width: 16, height: 120), headerReferenceSize: CGSize(width: 16, height: 120), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
