//
//  MovieDetailViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    var tableViewDataSource: [MovieDetailTableViewDataSource] = MovieDetailTableViewDataSource.allCases
    var data: [String: Any] = [:]
    // MARK: - Properties
	var presenter: MovieDetailPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieVideosTableViewCell.self, forCellReuseIdentifier: MovieVideosTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(ActorsTableViewCell.self, forCellReuseIdentifier: ActorsTableViewCell.className)
        tableView.register(UserRateTableViewCell.self, forCellReuseIdentifier: UserRateTableViewCell.className)
        tableView.registerCell(for: MovieVideosTableViewCell.className)
        tableView.registerCell(for: NotesTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
}

// MARK: - MovieDetailViewInterface
extension MovieDetailViewController: MovieDetailViewInterface {
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let baseCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            baseCell.listPayload = data
            baseCell.didTapActionInCell = { payload in
                switch item {
                    
                default:
                    return
                }
            }
        }
        
        if let cell = cell as? MovieVideosTableViewCell {
            cell.configCell()
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = tableViewDataSource[section]
        let titleHeader = item.titleOfHeader()
        if !titleHeader.isEmpty {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            headerView.contentView.backgroundColor = APP_COLOR
            headerView.lbTitle.text = titleHeader
            headerView.sectionNumber = section
            headerView.delegate = self
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = tableViewDataSource[section]
        let titleHeader = item.titleOfHeader()
        return titleHeader.isEmpty ? 0 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = tableViewDataSource[indexPath.section]
        return item.heightForRow()
    }
}

extension MovieDetailViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

extension MovieDetailViewController: HeaderViewDelegate {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int) {
        print("did tap button", section)
    }
}
