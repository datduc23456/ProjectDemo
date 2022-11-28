//
//  GenresSearchTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 28/11/2022.
//

import UIKit

class GenresSearchTableViewCell: BaseTableCollectionViewCell<GengesCollectionViewCell> {
    
    override var flowLayout: FlowLayoutAttribute? {
        return FlowLayoutAttribute(estimatedItemSize: UICollectionViewFlowLayout.automaticSize, minimumInteritemSpacing: 0, minimumLineSpacing: 8, footerReferenceSize: CGSize(width: 16, height: 2), headerReferenceSize: CGSize(width: 16, height: 2), scrollDirection: .vertical)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DTPBusiness.shared.listGenres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GengesCollectionViewCell.className, for: indexPath) as! GengesCollectionViewCell
        let genre = DTPBusiness.shared.listGenres[indexPath.row]
        cell.configCell(genre)
        cell.viewBackgroundImage.backgroundColor = .black
        cell.image.tintColor = .white
        cell.lbTitle.textColor = .white
        cell.contentView.backgroundColor = CHOOSE_GENRE_COLOR
        return cell
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.collectionView.layoutIfNeeded()
        self.layoutIfNeeded()
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        return CGSize.init(width: contentSize.width, height: contentSize.height + 40)
    }
}
