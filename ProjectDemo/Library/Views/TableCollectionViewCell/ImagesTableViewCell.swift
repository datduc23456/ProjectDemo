//
//  ImagesTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 26/11/2022.
//

import UIKit

class ImagesTableViewCell: BaseTableCollectionViewCell<TrendingCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 154, height: 95), minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 16, height: 95), headerReferenceSize: CGSize(width: 16, height: 95), scrollDirection: .horizontal)
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
