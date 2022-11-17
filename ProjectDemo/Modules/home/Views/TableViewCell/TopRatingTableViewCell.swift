//
//  TopRatingTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TopRatingTableViewCell: BaseWithCollectionTableViewCell<TopRatingCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(itemSize: CGSize(width: 244, height: 146), estimatedItemSize: CGSize(width: 244, height: 146), minimumInteritemSpacing: 8.0, minimumLineSpacing: 0.0, footerReferenceSize: CGSize(width: 0, height: 0), headerReferenceSize: CGSize(width: 0, height: 0), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
