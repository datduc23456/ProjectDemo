//
//  FavoriteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class FavoriteViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
	var presenter: FavoritePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.registerCell(for: FavoriteTableViewCell.className)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
        let bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.bottomDataSource = [.label("Number of movies watched"), .button(title: "Remove", isPrimary: false), .content(title: "Remove watched list", content: "Are you sure you would like to remove this film from the watched lits")]
        DispatchQueue.main.async {
            self.present(bottomSheet, animated: false)
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: - FavoriteViewInterface
extension FavoriteViewController: FavoriteViewInterface {
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.className, for: indexPath)
        cell.selectionStyle = .none
        cell.addTapGestureRecognizer { [weak self] in
//            Screen.
            self?.navigationController?.pushViewController(AppScreens.addnote.createViewController(), animated: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}
