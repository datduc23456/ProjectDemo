//
//  BaseTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import UIKit

enum HomeCollectionViewType {
    case home
}

struct FlowLayoutAttribute {
    var itemSize: CGSize
    var estimatedItemSize: CGSize
    var minimumInteritemSpacing: CGFloat
    var minimumLineSpacing: CGFloat
    var footerReferenceSize: CGSize
    var headerReferenceSize: CGSize
    var scrollDirection: UICollectionView.ScrollDirection
}

class BaseWithCollectionTableViewCell<T: UICollectionViewCell>: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var collectionView: UICollectionView!
    
    var flowLayout: FlowLayoutAttribute? {
        return nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        initWithCollectionView()
        print("Register: \(T.self)")
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
    
    func initWithCollectionView() {
        guard let flowLayout = flowLayout else { return }
        let collectionView = BaseCollectionBuilder().withCell(T.self)
            .withEstimatedItemSize(flowLayout.estimatedItemSize)
            .withItemSize(flowLayout.itemSize)
            .withFooterReferenceSize(flowLayout.footerReferenceSize)
            .withHeaderReferenceSize(flowLayout.headerReferenceSize)
            .withSpacingInGrid(flowLayout.minimumLineSpacing)
            .withSpacingInRow(flowLayout.minimumInteritemSpacing)
            .withScrollDirection(flowLayout.scrollDirection)
            .build()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(collectionView)
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
        return cell
    }
}
