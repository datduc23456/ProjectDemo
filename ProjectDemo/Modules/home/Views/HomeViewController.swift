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
        tableView.register(CinemaPopularTableViewCell.self, forCellReuseIdentifier: CinemaPopularTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(GengesTableViewCell.self, forCellReuseIdentifier: GengesTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        //customTabbarHeight
        
        tableView.sectionFooterHeight = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CinemaPopularTableViewCell.className, for: indexPath) as! CinemaPopularTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopRatingTableViewCell.className, for: indexPath) as! TopRatingTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.className, for: indexPath) as! TrendingTableViewCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: GengesTableViewCell.className, for: indexPath) as! GengesTableViewCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.contentView.backgroundColor = APP_COLOR
            headerView.lbTitle.text = "ABC" // set this however is appropriate for your app's model
            headerView.sectionNumber = section
            headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0:
            return 212
        case 1:
            return 146
        case 2:
            return 158
        case 3:
            return 40
        default:
            return 0
        }
    }
}

extension HomeViewController: HeaderViewDelegate {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int) {
        print("did tap button", section)
    }
}
