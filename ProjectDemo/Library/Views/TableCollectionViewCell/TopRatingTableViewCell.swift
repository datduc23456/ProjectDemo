//
//  TopRatingTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TopRatingTableViewCell: BaseTableCollectionViewCell<TopRatingCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 244, height: 146), minimumInteritemSpacing: 0.0, minimumLineSpacing: 8.0, footerReferenceSize: CGSize(width: 8.0, height: 146.0), headerReferenceSize: CGSize(width: 8.0, height: 146.0), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
