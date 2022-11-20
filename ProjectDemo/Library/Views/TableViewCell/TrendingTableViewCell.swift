//
//  TrendingTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TrendingTableViewCell: BaseWithCollectionTableViewCell<TrendingCollectionViewCell, Movie> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 105, height: 158), minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 16, height: 158), headerReferenceSize: CGSize(width: 16, height: 158), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
