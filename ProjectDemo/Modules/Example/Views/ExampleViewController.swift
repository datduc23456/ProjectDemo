//
//  ExampleViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ExampleViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var listGenre: [Genre] = []
    // MARK: - Properties
	var presenter: ExamplePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ABCTableViewCell.self, forCellReuseIdentifier: ABCTableViewCell.className)
        collectionView.registerCell(for: GengesCollectionViewCell.className)
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        ServiceCore.shared.request(GenreResponse.self, targetType: CoreTargetType.genreList, successBlock: { [weak self] response in
            guard let `self` = self else { return }
            self.listGenre = response.genres
            self.collectionView.reloadData()
        }, failureBlock: { _ in
            
        })
    }
}

// MARK: - ExampleViewInterface
extension ExampleViewController: ExampleViewInterface {
}

extension ExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ABCTableViewCell.className, for: indexPath) as! ABCTableViewCell
        
        return cell
    }
}

extension ExampleViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listGenre.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GengesCollectionViewCell.className, for: indexPath) as! GengesCollectionViewCell
        cell.configCell(self.listGenre[indexPath.row])
        return cell
    }
    
    
}
