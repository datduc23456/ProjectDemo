//
//  NoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class NoteViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
	var presenter: NotePresenterInterface!
    var bottomSheet: BaseViewBottomSheetViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        tableView.registerCell(for: UserNoteTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
//            self.presenter.didTapSearch()
        }
        navigation.lbTitle.text = "User note"
        navigation.configContentNav(.tabbar)
    }
    
    func configView() {
        
        bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.bottomDataSource = [.content(title: "Remove Favorite", content: "Are you sure you would like to remove this film from the favorite"), .button(title: "Edit", isPrimary: true), .button(title: "Remove", isPrimary: false)]
        
        tableView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
}

// MARK: - NoteViewInterface
extension NoteViewController: NoteViewInterface {
}

extension NoteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserNoteTableViewCell.className, for: indexPath) as! UserNoteTableViewCell
        cell.selectionStyle = .none
        cell.didTapEdit = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
//                self.bottomSheet.payload = movieObject
                self.present(self.bottomSheet, animated: true, completion: {
                    self.bottomSheet.stackContent.delegate = self
                })
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 311
    }
    
}

extension NoteViewController: BoottomSheetStackViewDelegate {
    func didSelect(_ bottomSheetStackView: BottomSheetStackView, selectedIndex index: Int) {
        if index == 2, let movieObject = self.bottomSheet.payload as? MovieDetailObject {
//            self.realmUtils.deleteObject(object: movieObject)
//            self.dataSource = Dictionary(grouping: realmUtils.getListObjects(type: MovieDetailObject.self), by: { $0.releaseDate })
//            self.tableView.reloadData()
        }
        if index == 2 || index == 3 {
            self.bottomSheet.dismiss(animated: true)
        }
    }
}
