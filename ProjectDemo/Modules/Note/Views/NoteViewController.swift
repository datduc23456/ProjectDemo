//
//  NoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

final class NoteViewController: BaseViewController {
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    // MARK: - Properties
	var presenter: NotePresenterInterface!
    var bottomSheet: BaseViewBottomSheetViewController!
    var reviews: [ReviewsResultObject] = [] {
        didSet {
            tableView.reloadData()
            tableView.isHidden = reviews.isEmpty
        }
    }
    var bottomTitle: String = ""
    var bottomContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configView()
        tableView.register(UINib(nibName: AddNoteHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: AddNoteHeaderView.reuseIdentifier)
        tableView.registerCell(for: MyNoteTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            AdMobManager.shared.show(key: "InterstitialAd")
            self.presenter.didTapSearch()
        }
        navigation.imgSetting.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSetting()
        }
        navigation.lbTitle.text = "Your note"
        navigation.configContentNav(.tabbar)
    }
    
    func configView() {
        
        tableView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            self.presenter.didRefresh()
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        tableView.backgroundColor = APP_COLOR
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        self.presenter.didTapAddNote()
    }
}

// MARK: - NoteViewInterface
extension NoteViewController: NoteViewInterface {
    func getMyReviews(_ data: [ReviewsResultObject]) {
        self.reviews = data
        delay(1, closure: {
            self.tableView.headRefreshControl.endRefreshing()
        })
    }
    
}

extension NoteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyNoteTableViewCell.className, for: indexPath) as! MyNoteTableViewCell
        let review = self.reviews[indexPath.row]
        cell.selectionStyle = .none
        cell.configCell(review)
        cell.didTapEdit = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.bottomSheet = BaseViewBottomSheetViewController()
                self.bottomSheet.payload = review
                self.bottomTitle = !review.originalTitle.isEmpty ? review.originalTitle : review.originalName
                self.bottomContent = DTPBusiness.shared.mapToGenreName(Array(review.genreIDS))
                self.bottomSheet.bottomDataSource = [.content(title: self.bottomTitle, content: self.bottomContent), .button(title: "Edit", isPrimary: true), .button(title: "Remove", isPrimary: false)]
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddNoteHeaderView.reuseIdentifier) as! AddNoteHeaderView
        headerView.adView.register(id: "")
        headerView.contentView.backgroundColor = APP_COLOR
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
}

extension NoteViewController: BoottomSheetStackViewDelegate {
    func didSelect(_ bottomSheetStackView: BottomSheetStackView, selectedIndex index: Int) {
        if index == 2 || index == 3 {
            self.bottomSheet.shouldDismissSheet()
        }
        if index == 2, let review = self.bottomSheet.payload as? ReviewsResultObject {
            presenter.showReview(review)
        }
        if index == 3, let review = self.bottomSheet.payload as? ReviewsResultObject {
            DTPBusiness.shared.deleteReviewsResultObject(review, completion: {_ in})
            presenter.didRefresh()
        }
    }
}

extension NoteViewController: HeaderViewDelegate {
    func headerView(_ customHeader: UITableViewHeaderFooterView, didTapButtonInSection section: Int) {
        self.presenter.didTapAddNote()
    }
}
