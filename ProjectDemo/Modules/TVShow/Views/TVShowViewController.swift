//
//  TVShowViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class TVShowViewController: BaseViewController {

    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var icFavorite: UIImageView!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var imgBackGround: UIImageView!
    @IBOutlet weak var viewLayer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    // MARK: - Properties
	var presenter: TVShowPresenterInterface!
    var tableViewDataSource: [TVShowTableViewDataSource] = TVShowTableViewDataSource.allCases
    var data: [String: Any] = [:]
    var movie: Movie?
    var movieDetail: MovieDetail?
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                self.icFavorite.image = UIImage(named: "ic_heart_color")
            } else {
                self.icFavorite.image = UIImage(named: "ic_heart")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TVShowTopUpTableViewCell.self, forCellReuseIdentifier: TVShowTopUpTableViewCell.className)
        tableView.register(TVShowPopularTableViewCell.self, forCellReuseIdentifier: TVShowPopularTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(UINib(nibName: BigNativeAdHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: BigNativeAdHeaderView.reuseIdentifier)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        viewLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        presenter.viewDidLoad()
        let navigation: BaseNavigationView = NavigationBarView.initFromNib(type: .base, frame: CGRect.init(x: 0, y: 0, width: CommonUtil.SCREEN_WIDTH, height: AppDelegate.shared.window!.safeAreaInsets.top + 54)) as! BaseNavigationView
            //.init(frame: CGRect.init(x: 0, y: 0, width: CommonUtil.SCREEN_WIDTH, height: AppDelegate.shared.window!.safeAreaInsets.top + 44))
        self.view.addSubview(navigation)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            AdMobManager.shared.show(key: "InterstitialAd")
            self.presenter.didTapSearch()
        }
        navigation.imgSetting.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSetting()
        }
        navigation.lbTitle.text = "TV Shows"
        navigation.configContentNav(.tvshow)
        
        viewFavorite.addTapGestureRecognizer { [weak self] in
            guard let `self` = self, let movie = self.movie else { return }
            self.presenter.didTapFavorite(movie, isFavorite: self.isFavorite)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstLayout {
            viewLayer.applyGradient(colours: [.black.withAlphaComponent(0.1), .black.withAlphaComponent(1)])
            isFirstLayout = !isFirstLayout
        }
    }
    
    @IBAction func playAction(_ sender: Any) {
        if let movie = movieDetail, let video = movie.videos.video.first {
            self.presenter.didTapPlayVideo(video)
        }
    }
}

// MARK: - TVShowViewInterface
extension TVShowViewController: TVShowViewInterface {
    func getTVShowDetail(_ response: MovieDetail) {
        self.configMovieDetail(response)
    }
    
    func didDeleteMovieObject() {
        self.isFavorite = false
    }
    
    func didInsertMovieObject() {
        self.isFavorite = true
    }
    
    func fetchRealmMovieDetailObjectWithId(_ object: [MovieDetailObject]) {
        if !object.isEmpty {
            self.isFavorite = true
        } else {
            self.isFavorite = false
        }
    }
    
    func getTVShowLastest(_ response: MovieResponse) {
//        let listMovie = response.results
//        let first5 = Array(listMovie.prefix(5))
//        self.data.updateValue(listMovie, forKey: "\(TVShowTableViewDataSource.topUp)")
//        tableView.reloadSections(IndexSet([0]), with: .none)
//        self.presenter.didChangeMovieHeader(listMovie.first!)
    }
    
    func getGenresList(_ response: GenreResponse) {
        
    }
    
    func getTopRate(_ response: MovieResponse) {
        let listMovie = response.results
//        let first5 = Array(listMovie.prefix(5))
        
        self.data.updateValue(listMovie, forKey: "\(TVShowTableViewDataSource.topUp)")
        DTPBusiness.shared.tvShowSelectedId = listMovie.first!.id
        tableView.reloadSections(IndexSet([0]), with: .none)
        self.presenter.didChangeMovieHeader(listMovie.first!)
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        self.data.updateValue(response.results, forKey: "\(TVShowTableViewDataSource.popular)")
        tableView.reloadSections(IndexSet([1]), with: .none)
    }
    
    func getTrendingTv(_ response: MovieResponse) {
        self.data.updateValue(response.results, forKey: "\(TVShowTableViewDataSource.trending)")
        tableView.reloadSections(IndexSet([2]), with: .none)
    }
}


extension TVShowViewController: UITableViewDataSource, UITableViewDelegate {
    fileprivate func configMovieDetail(_ movie: MovieDetail) {
        self.movieDetail = movie
        self.imgBackGround.kf.setImage(with: URL(string: "\(baseURLImage)\(movie.posterPath)"))
        self.lbTitle.text = movie.name
        self.lbVoteAvg.text = "\(movie.voteAverage.roundToPlaces(places: 1))"
        self.lbYear.text = CommonUtil.getYearFromDate(movie.releaseDate)
//        self.tableView.reloadSections(IndexSet([0]), with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let tableViewCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            tableViewCell.listPayload = data
            tableViewCell.didTapActionInCell = { payload in
                switch item {
                case .topUp:
                    if let movie = payload as? Movie {
                        for collectionViewCell in tableViewCell.collectionView.visibleCells {
                            if let tvShowTopUpCollectionViewCell = collectionViewCell as? TVShowTopUpCollectionViewCell {
                                tvShowTopUpCollectionViewCell.icPlay.isHidden = true
                            }
                        }
                        DTPBusiness.shared.tvShowSelectedId = movie.id
                        self.movie = movie
                        self.presenter.didChangeMovieHeader(movie)
                    }
                case .popular, .trending:
                    if let movie = payload as? Movie {
                        self.presenter.didTapToMovie(movie)
                    }
                default:
                    return
                }
            }
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let item = tableViewDataSource[section]
        if item == .popular {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BigNativeAdHeaderView") as! BigNativeAdHeaderView
            headerView.contentView.backgroundColor = APP_COLOR
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let item = tableViewDataSource[section]
        if item == .popular {
            return 370
        }
        return 0
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
    func headerView(_ customHeader: UITableViewHeaderFooterView, didTapButtonInSection section: Int) {
        let item = tableViewDataSource[section]
        self.presenter.didTapHeaderView(item)
    }
}
