//
//  GengesListTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 20/11/2022.
//

import UIKit

class GengesListTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var listPayload: [Any] = []
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    

    @IBOutlet weak var collectionView: BaseCollectionView!
    var payload: [Genre] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    func initCollectionViewCell() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        collectionView.registerCell(for: GengesCollectionViewCell.className)
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: 16, height: 1)
        collectionViewFlowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = collectionViewFlowLayout
        initCollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension GengesListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return payload.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GengesCollectionViewCell.className, for: indexPath)  as? GengesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let payload = self.payload[indexPath.row]
        let isSelected: Bool = payload.id == DTPBusiness.shared.genreSelectedId
        cell.configCell(payload, isSelected: isSelected)
        cell.didTapAction = { [weak self] any in
            guard self != nil else { return }
            self?.didTapActionInCell(any)
            for cell in collectionView.visibleCells {
                if let c = cell as? GengesCollectionViewCell, c.genre.id != DTPBusiness.shared.genreSelectedId {
                    c.unsected()
                    c.isSelect = false
                }
            }
        }
        return cell
    }
}
