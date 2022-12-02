//
//  GenersViewController.swift
//  ProjectDemo
//
//  Created by đạt on 26/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class GenersViewController: BaseCollectionViewController<GengesCollectionViewCell> {
    
    override var numberOfColumn: Int {
        return 0
    }
    
    override var spacing: Double {
        return 12
    }
    
    // MARK: - Properties
	var presenter: GenersPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.semanticContentAttribute = .forceLeftToRight
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
        navigation.lbTitle.text = "Move Geners"
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DTPBusiness.shared.listGenres.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! GengesCollectionViewCell
        let genre = DTPBusiness.shared.listGenres[indexPath.row]
//        let isSelected: Bool = genre.id == DTPBusiness.shared.genreSelectedId
//        cell.configCell(genre, isSelected: isSelected)
        cell.configCell(genre)
        cell.viewBackgroundImage.backgroundColor = .black
        cell.image.tintColor = .white
        cell.lbTitle.textColor = .white
        cell.contentView.backgroundColor = CHOOSE_GENRE_COLOR
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
//            for cell in collectionView.visibleCells {
//                if let c = cell as? GengesCollectionViewCell {
//                    c.unsected()
//                    c.isSelect = false
//                }
//            }
            self.presenter.didTapGenres(genre)
        }
        return cell
    }
}

// MARK: - GenersViewInterface
extension GenersViewController: GenersViewInterface {
}
