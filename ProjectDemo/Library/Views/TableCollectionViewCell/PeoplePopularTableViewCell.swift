//
//  PeoplePersonTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 27/11/2022.
//

import UIKit

class PeoplePopularTableViewCell: BaseTableCollectionViewCell<PeoplePopularCollectionViewCell> {

    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: CGSize(width: 106, height: 150), minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 8, height: 150), headerReferenceSize: CGSize(width: 8, height: 150), scrollDirection: .horizontal)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PeoplePopularCollectionViewCell.className, for: indexPath) as! PeoplePopularCollectionViewCell
        let payload = self.listPayload[indexPath.row]
        cell.configCell(payload, isSearch: true)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            self.didTapActionInCell(any)
        }
        return cell
    }
}
