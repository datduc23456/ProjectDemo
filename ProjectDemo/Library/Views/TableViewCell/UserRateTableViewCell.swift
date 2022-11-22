//
//  UserRateTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class UserRateTableViewCell: BaseWithCollectionTableViewCell<UserRateCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 256, height: 157), minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 8, height: 157), headerReferenceSize: CGSize(width: 8, height: 157), scrollDirection: .horizontal)
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
