//
//  ActorsTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class ActorsTableViewCell: BaseWithCollectionTableViewCell<ActorsCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 150, height: 96), minimumInteritemSpacing: 0, minimumLineSpacing: 12, footerReferenceSize: CGSize(width: 12, height: 96), headerReferenceSize: CGSize(width: 12, height: 96), scrollDirection: .horizontal)
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
