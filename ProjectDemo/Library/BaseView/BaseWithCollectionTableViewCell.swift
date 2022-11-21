//
//  BaseTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 16/11/2022.
//

import UIKit

struct FlowLayoutAttribute {
    var estimatedItemSize: CGSize
    var minimumInteritemSpacing: CGFloat
    var minimumLineSpacing: CGFloat
    var footerReferenceSize: CGSize
    var headerReferenceSize: CGSize
    var scrollDirection: UICollectionView.ScrollDirection
}

class BaseWithCollectionTableViewCell<T: UICollectionViewCell, D: Decodable>: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: BaseCollectionView!
    var listPayload: [D] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
            .withFooterReferenceSize(flowLayout.footerReferenceSize)
            .withHeaderReferenceSize(flowLayout.headerReferenceSize)
            .withSpacingInGrid(flowLayout.minimumLineSpacing)
            .withSpacingInRow(flowLayout.minimumInteritemSpacing)
            .withScrollDirection(flowLayout.scrollDirection)
            .build()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as! T
//        let payload = self.listPayload[indexPath.row]
//        if let baseCell = cell as? BaseCollectionViewCell {
//            baseCell.configCell(payload)
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = flowLayout else {
            return UICollectionViewFlowLayout.automaticSize
        }
        if flowLayout.estimatedItemSize == UICollectionViewFlowLayout.automaticSize {
            return CGSize(width: 1, height: 34)
        }
        return flowLayout.estimatedItemSize
    }
}
