//
//  GengesTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 17/11/2022.
//

import UIKit

class GengesTableViewCell: BaseWithCollectionTableViewCell<GengesCollectionViewCell> {
    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: UICollectionViewFlowLayout.automaticSize, minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 16, height: 32), headerReferenceSize: CGSize(width: 16, height: 32), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
