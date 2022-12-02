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

    @IBOutlet weak var btnAddNote: UIButton!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
	var presenter: NotePresenterInterface!
    var bottomSheet: BaseViewBottomSheetViewController!
    var reviews: [ReviewsResultObject] = []
    var bottomTitle: String = ""
    var bottomContent: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        configView()
        tableView.registerCell(for: MyNoteTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.reloadData()
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSearch()
        }
        navigation.lbTitle.text = "User note"
        navigation.configContentNav(.tabbar)
    }
    
    func configView() {
        bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.bottomDataSource = [.content(title: bottomTitle, content: bottomContent), .button(title: "Edit", isPrimary: true), .button(title: "Remove", isPrimary: false)]
        
        tableView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            self.presenter.didRefresh()
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        
        btnAddNote.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapAddNote()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
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
//                self.bottomSheet.payload = movieObject
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

extension NoteViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "ic_emptyNote")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "This movie has no note yet"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        return UIImage(named: "ic_plus")!
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let title = "Add note"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
        return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
