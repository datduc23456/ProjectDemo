//
//  TVShowViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class TVShowViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    // MARK: - Properties
	var presenter: TVShowPresenterInterface!
    var tableViewDataSource: [TVShowTableViewDataSource] = TVShowTableViewDataSource.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TVShowTopUpTableViewCell.self, forCellReuseIdentifier: TVShowTopUpTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
    
}

// MARK: - TVShowViewInterface
extension TVShowViewController: TVShowViewInterface {
}


extension TVShowViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTopUpTableViewCell.className, for: indexPath)
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

extension TVShowViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

extension TVShowViewController: HeaderViewDelegate {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int) {
        print("did tap button", section)
    }
}
