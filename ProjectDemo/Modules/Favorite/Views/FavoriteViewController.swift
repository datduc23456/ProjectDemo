//
//  FavoriteViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import KafkaRefresh

enum FavoriteFilterType {
    case movie
    case tvshow
}

enum MovieFilterType: CaseIterable {
    case all
    case nameAZ
    case nameZA
    case myRating
    
    var title: String {
        switch self {
        case .all:
            return "All Movies"
        case .nameAZ:
            return "Name A-Z"
        case .nameZA:
            return "Name Z-A"
        case .myRating:
            return "My rating"
        }
    }
}

final class FavoriteViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var btnFilter: UIButton!
    @IBOutlet weak var btnMovie: UIButton!
    @IBOutlet weak var btnTVShow: UIButton!
    @IBOutlet weak var tableView: UITableView!
	var presenter: FavoritePresenterInterface!
    var dataSource: [(String, [MovieDetailObject])] = []
    var bottomSheet: BaseViewBottomSheetViewController!
    var filterType: FavoriteFilterType = .movie
    var movieFilterType: MovieFilterType {
        set {
            DTPBusiness.shared.movieFilterType = newValue
            presenter.getMovieFavorite(filterType)
        } get {
            return DTPBusiness.shared.movieFilterType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        presenter.viewDidLoad()
        tableView.registerCell(for: SmallNativeAdTableViewCell.className)
        tableView.registerCell(for: FavoriteTableViewCell.className)
        tableView.register(UINib(nibName: FavoriteHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: FavoriteHeaderView.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 0
//        tableView.header
        tableView.tableHeaderView = nil
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSearch()
        }
        navigation.imgSetting.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSetting()
        }
        navigation.lbTitle.text = "Favorite"
        navigation.configContentNav(.tabbar)
    }
    
    func configView() {
        tableView.bindHeadRefreshHandler({ [weak self] in
            guard let `self` = self else { return }
            self.presenter.getMovieFavorite(self.filterType)
        }, themeColor: .white, refreshStyle: .replicatorCircle)
        
        btnMovie.addTapGestureRecognizer { [weak self] in
            guard let `self` = self, self.filterType != .movie else { return }
            self.filterType = .movie
            self.presenter.getMovieFavorite(.movie)
            self.btnMovie.backgroundColor = UIColor(hex: "#FB716E")
            self.btnTVShow.backgroundColor = UIColor(hex: "#232228")
            self.btnTVShow.borderWidth = 1
            self.btnMovie.borderWidth = 0
        }
        
        btnTVShow.addTapGestureRecognizer { [weak self] in
            guard let `self` = self, self.filterType != .tvshow else { return }
            self.filterType = .tvshow
            self.presenter.getMovieFavorite(.tvshow)
            self.btnTVShow.backgroundColor = UIColor(hex: "#FB716E")
            self.btnMovie.backgroundColor = UIColor(hex: "#232228")
            self.btnMovie.borderWidth = 1
            self.btnTVShow.borderWidth = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getMovieFavorite(filterType)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        bottomSheet = BaseViewBottomSheetViewController()
        bottomSheet.payload = 0
        bottomSheet.bottomDataSource = MovieFilterType.allCases.compactMap({ return .label(title: $0.title, isChoose: $0 == movieFilterType)})
        self.present(self.bottomSheet, animated: true, completion: {
            self.bottomSheet.stackContent.delegate = self
        })
    }
}

// MARK: - FavoriteViewInterface
extension FavoriteViewController: FavoriteViewInterface {
    func getMovieFavorite(_ data: [String : [MovieDetailObject]]) {
        var movies = data
        for key in movies.keys {
            switch movieFilterType {
            case .myRating:
                let sortList = movies[key]?.sorted(by: {$0.voteAverage > $1.voteAverage})
                movies.updateValue(sortList.isNil(value: []), forKey: key)
            case .all, .nameAZ:
                let sortList = movies[key]?.sorted(by: {
                    let lhsMovieName = $0.isTVShow ? $0.originalName : $0.originalTitle
                    let rhsMovieName = $1.isTVShow ? $1.originalName : $1.originalTitle
                    return lhsMovieName < rhsMovieName
                })
                movies.updateValue(sortList.isNil(value: []), forKey: key)
            default:
                let sortList = movies[key]?.sorted(by: {
                    let lhsMovieName = $0.isTVShow ? $0.originalName : $0.originalTitle
                    let rhsMovieName = $1.isTVShow ? $1.originalName : $1.originalTitle
                    return lhsMovieName > rhsMovieName
                })
                movies.updateValue(sortList.isNil(value: []), forKey: key)
            }
        }
        dataSource = movies.sorted(by: { $0.0 > $1.0 })
        dataSource.append(("", []))
        tableView.reloadData()
        delay(1, closure: {
            self.tableView.headRefreshControl.endRefreshing()
        })
    }
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        let values = dataSource[section]
        return values.1.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 { return 0 }
        if section == 1 {
             return 23
        }
        return 43
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FavoriteHeaderView.reuseIdentifier) as! FavoriteHeaderView
        let key = dataSource[section].0
        if key.isEmpty { return nil }
        if section == 1 {
            headerView.viewSegment.isHidden = true
        } else {
            headerView.viewSegment.isHidden = false
        }
        headerView.contentView.backgroundColor = APP_COLOR
        headerView.lbTitle.text = key
        headerView.lbTitle.font = UIFont(name: "Nexa-Bold", size: 14)
        headerView.lbTitle.textColor = .white.withAlphaComponent(0.5)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SmallNativeAdTableViewCell.className, for: indexPath) as! SmallNativeAdTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.className, for: indexPath) as! FavoriteTableViewCell
        let key = dataSource[indexPath.section].0
        let listMovieDetail = dataSource[indexPath.section].1
        let movieObject = listMovieDetail[indexPath.row]
        cell.selectionStyle = .none
        cell.filmNoteView.viewRating.isHidden = true
        cell.filmNoteView.viewDate.isHidden = true
        cell.filmNoteView.lbTitle.text = !movieObject.originalTitle.isEmpty ? movieObject.originalTitle : movieObject.originalName
        cell.filmNoteView.img.kf.setImage(with: URL(string: "\(baseURLImage)\(movieObject.posterPath)"))
        cell.filmNoteView.lbVoteAvg.text = "\(movieObject.voteAverage.roundToPlaces(places: 1))"
        cell.filmNoteView.lbYear.text = CommonUtil.getYearFromDate(movieObject.isTVShow ? movieObject.firstAirDate : movieObject.releaseDate)
        cell.filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(Array(movieObject.genreIDS))
        cell.didTapRemove = { [weak self] in
            guard let `self` = self else { return }
            DispatchQueue.main.async {
                self.bottomSheet = BaseViewBottomSheetViewController()
                self.bottomSheet.bottomDataSource = [.content(title: "Remove Favorite", content: "Are you sure you would like to remove this film from the favorite"), .button(title: "Remove", isPrimary: true), .button(title: "No, Thank", isPrimary: false)]
                self.bottomSheet.payload = movieObject
                self.present(self.bottomSheet, animated: true, completion: {
                    self.bottomSheet.stackContent.delegate = self
                })
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 { return 30 }
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

extension FavoriteViewController: BoottomSheetStackViewDelegate {
    func didSelect(_ bottomSheetStackView: BottomSheetStackView, selectedIndex index: Int) {
        if let _ = bottomSheet.payload as? Int {
            switch index {
            case 1:
                movieFilterType = .all
            case 2:
                movieFilterType = .nameAZ
            case 3:
                movieFilterType = .nameZA
            default:
                movieFilterType = .myRating
            }
            self.bottomSheet.shouldDismissSheet()
        } else if index == 2, let movieObject = self.bottomSheet.payload as? MovieDetailObject {
            self.realmUtils.deleteObject(object: movieObject)
            self.presenter.getMovieFavorite(self.filterType)
        }
        if index == 2 || index == 3 {
            self.bottomSheet.shouldDismissSheet()
        }
    }
}
