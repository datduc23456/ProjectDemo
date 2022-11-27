//
//  FavoriteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

final class FavoriteViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
	var presenter: FavoritePresenterInterface!
    var dataSource: [String: [MovieDetailObject]] = [:]
    var bottomSheet: BaseViewBottomSheetViewController {
        let bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.bottomDataSource = [.content(title: "Remove Favorite", content: "Are you sure you would like to remove this film from the favorite"), .button(title: "Remove", isPrimary: true), .button(title: "No, Thank", isPrimary: false)]
        return bottomSheet
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.registerCell(for: FavoriteTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
        dataSource = Dictionary(grouping: realmUtils.getListObjects(type: MovieDetailObject.self), by: { $0.releaseDate })
        tableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = Array(dataSource.keys)[section]
        return dataSource[key].isNil(value: []).count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        let key = Array(dataSource.keys)[section]
        headerView.contentView.backgroundColor = APP_COLOR
        headerView.lbTitle.text = key.toDateFormat(toFormat: "MMM yyyy")
        headerView.lbTitle.font = UIFont(name: "Nexa-Bold", size: 14)
        headerView.lbTitle.textColor = .white.withAlphaComponent(0.5)
        headerView.btnSeeMore.isHidden = true
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.className, for: indexPath) as! FavoriteTableViewCell
        let key = Array(dataSource.keys)[indexPath.section]
        let listMovieDetail = dataSource[key].isNil(value: [])
        let movieObject = listMovieDetail[indexPath.row]
        cell.selectionStyle = .none
        cell.filmNoteView.viewRating.isHidden = true
        cell.filmNoteView.viewDate.isHidden = true
        cell.filmNoteView.lbTitle.text = movieObject.originalTitle
        cell.filmNoteView.img.kf.setImage(with: URL(string: "\(baseURLImage)\(movieObject.posterPath)"))
        cell.filmNoteView.lbVoteAvg.text = "\(movieObject.voteAverage.roundToPlaces(places: 1))"
        cell.filmNoteView.lbYear.text = CommonUtil.getYearFromDate(movieObject.firstAirDate)
        cell.filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(Array(movieObject.genreIDS))
        cell.didTapRemove = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.present(self.bottomSheet, animated: true)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
}

extension FavoriteViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "ic_emptyFavorite")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "No found theater!"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
