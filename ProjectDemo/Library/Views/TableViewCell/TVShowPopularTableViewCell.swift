//
//  TVShowPopularTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 21/11/2022.
//

import UIKit

class TVShowPopularTableViewCell: BaseTableCollectionViewCell<TVShowCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 186, height: 195), minimumInteritemSpacing: 0, minimumLineSpacing: 12, footerReferenceSize: CGSize(width: 16, height: 195), headerReferenceSize: CGSize(width: 16, height: 195), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
