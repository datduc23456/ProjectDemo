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
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCollectionViewCell.className, for: indexPath) as! TVShowCollectionViewCell
        let payload = self.listPayload[indexPath.row]
        cell.configCell(payload, isTVShow: true)
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            self.didTapActionInCell(any)
        }
        return cell
    }
}
