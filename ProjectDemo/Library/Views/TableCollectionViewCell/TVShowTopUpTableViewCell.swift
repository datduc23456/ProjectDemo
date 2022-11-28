//
//  TVShowTopUpTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//

import UIKit

class TVShowTopUpTableViewCell: BaseTableCollectionViewCell<TVShowTopUpCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 100, height: 120), minimumInteritemSpacing: 0, minimumLineSpacing: 0, footerReferenceSize: CGSize(width: 8, height: 120), headerReferenceSize: CGSize(width: 8, height: 120), scrollDirection: .horizontal)
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
