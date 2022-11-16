//
//  BaseTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import UIKit

struct FlowLayoutAttribute {
    var itemSize: CGSize
    var estimatedItemSize: CGSize
    var minimumInteritemSpacing: CGFloat
    var minimumLineSpacing: CGFloat
    var footerReferenceSize: CGSize
    var headerReferenceSize: CGSize
}

class BaseWithCollectionTableViewCell: UITableViewCell {
    
    var isFirstLoad: Bool = true
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("style")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initWithCollectionView<T: UICollectionViewCell>(_ attribute: FlowLayoutAttribute, _ type: T.Type) {
        if isFirstLoad {
            let collectionView = BaseCollectionBuilder().withCell(T.self)
                .withEstimatedItemSize(attribute.estimatedItemSize)
                .withItemSize(attribute.itemSize)
                .withFooterReferenceSize(attribute.footerReferenceSize)
                .withHeaderReferenceSize(attribute.headerReferenceSize)
                .withSpacingInGrid(attribute.minimumLineSpacing)
                .withSpacingInRow(attribute.minimumInteritemSpacing)
                .build()
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(collectionView)
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            isFirstLoad = !isFirstLoad
        }
    }
}
