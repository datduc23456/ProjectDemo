//
//  HomeViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
	var presenter: HomePresenterInterface!
    
    override func viewDidLoad() {
        tableView.register(TopRatingTableViewCell.self, forCellReuseIdentifier: TopRatingTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopRatingTableViewCell.className, for: indexPath) as! TopRatingTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
