//
//  UserNoteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

final class UserNoteViewController: BaseViewController {
    
    // MARK: - Properties
    var presenter: UserNotePresenterInterface!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var filmNoteView: FilmNoteView!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    var reviews: [ReviewsResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        reviews = (movieDetail?.reviews.results).isNil(value: [])
        tableView.reloadData()
        configHeader()
        tableView.registerCell(for: UserNoteTableViewCell.className)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.contentSizeDelegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.navigation)
        navigation.btnBack.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
        navigation.lbTitle.text = "User note"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func configHeader() {
        guard let movieDetail = movieDetail else { return }
        filmNoteView.viewVoteAvg.isHidden = true
        filmNoteView.viewDate.isHidden = true
        filmNoteView.viewRemove.isHidden = true
        filmNoteView.img.setImageUrlWithPlaceHolder(url: URL.init(string: "\(baseURLImage)\(movieDetail.posterPath)"))
        filmNoteView.lbTitle.text = !movieDetail.originalTitle.isEmpty ? movieDetail.originalTitle : movieDetail.originalName
        filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(movieDetail.genres.map({$0.id}))
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        presenter.didTapAddNote()
    }
}

// MARK: - UserNoteViewInterface
extension UserNoteViewController: UserNoteViewInterface {
    var movieDetail: MovieDetail? {
        if let movieDetail = payload as? MovieDetail {
            return movieDetail
        }
        return nil
    }
}

extension UserNoteViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserNoteTableViewCell.className, for: indexPath) as! UserNoteTableViewCell
        let review = reviews[indexPath.section]
        cell.selectionStyle = .none
        cell.congfigCell(review)
        cell.layoutIfNeeded()
        cell.stackView.linearGradientBackground(angleInDegs: 180, colors: [UIColor(hex: "#171A21").cgColor, UIColor(hex: "#0D1015").cgColor])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
}

extension UserNoteViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

extension UserNoteViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "ic_emptyNote")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "This movie has no note yet"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
