//
//  MovieDetailViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var btnWatchedList: UIButton!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var icHeart: UIImageView!
    @IBOutlet weak var viewFavorite: UIView!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
    @IBOutlet weak var imgBackDrop: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var viewToast: UIView!
    
    let watchedListVc = AppScreens.watchedList.createViewController()
    var tableViewDataSource: [MovieDetailTableViewDataSource] = MovieDetailTableViewDataSource.allCases
    var data: [String: Any] = [:]
    var trailer: Video?
    var isExpandTextView: Bool = false
    var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                self.icHeart.image = UIImage(named: "ic_heart_color")
            } else {
                self.icHeart.image = UIImage(named: "ic_heart")
            }
        }
    }
    var selectedIndex: Int = 0
    var movieDetail: MovieDetail?
    var watchedListObject: WatchedListObject?
    // MARK: - Properties
	var presenter: MovieDetailPresenterInterface!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.register(MovieVideosTableViewCell.self, forCellReuseIdentifier: MovieVideosTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.className)
        tableView.register(ActorsTableViewCell.self, forCellReuseIdentifier: ActorsTableViewCell.className)
        tableView.register(UserRateTableViewCell.self, forCellReuseIdentifier: UserRateTableViewCell.className)
        tableView.register(TVShowPopularTableViewCell.self, forCellReuseIdentifier: TVShowPopularTableViewCell.className)
        tableView.registerCell(for: TextExpandTableViewCell.className)
        tableView.registerCell(for: MovieVideosTableViewCell.className)
        tableView.registerCell(for: NotesTableViewCell.className)
        tableView.registerCell(for: AddNoteTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
        viewFavorite.addTapGestureRecognizer { [weak self] in
            guard let `self` = self, let movieDetail = self.movieDetail else { return }
            self.presenter.didTapFavorite(movieDetail, isFavorite: self.isFavorite)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
        scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewWillAppear(animated)
        if isFirstLayout {
            viewGradient.applyGradient(colours: [.black.withAlphaComponent(0.1), .black.withAlphaComponent(0.5)])
            isFirstLayout = !isFirstLayout
        }
    }
    
    @IBAction func trailerAction(_ sender: Any) {
        if let trailer = self.trailer {
            presenter.didTapPlayVideo(trailer)
        }
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        if let movieDetail = movieDetail, watchedListObject == nil {
            watchedListVc.payload = movieDetail
            self.present(watchedListVc, animated: true)
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - MovieDetailViewInterface
extension MovieDetailViewController: MovieDetailViewInterface {
    
    var id: (Int, Bool) {
        get {
            if let id = payload as? (Int, Bool) {
                return id
            }
            return (299536, false)
        }
    }
    
    func configHeaderView(_ response: MovieDetail) {
        let voteAvg = response.voteAverage.roundToPlaces(places: 1)
        let listVideos = response.videos.video
        if listVideos.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .videos || $0 == .images})
        }
        if response.recommendations.results.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .trending})
        }
        if response.seasons.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .season})
        }
        if response.overview.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .overview})
        }
        if response.reviews.results.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .notes})
            if let index = self.tableViewDataSource.firstIndex(where: {$0.isRate()}) {
                var rateRow = self.tableViewDataSource[index]
                rateRow.changeRate()
                self.tableViewDataSource[index] = rateRow
            }
        }
        self.movieDetail = response
        self.trailer = listVideos.first
        imgPoster.kf.setImage(with: URL(string: "\(baseURLImage)\(response.posterPath)"))
        imgBackDrop.kf.setImage(with: URL(string: "\(baseURLImage)\(response.backdropPath)"))
        lbYear.text = CommonUtil.getYearFromDate(response.lastAirDate)
        lbVoteAvg.text = "\(voteAvg)"
        lbName.text = response.title
        lbGenres.text = DTPBusiness.shared.mapToGenreName(response.genres.map({$0.id}))
    }
    
    func getTVShowDetail(_ response: MovieDetail) {
        self.tableViewDataSource = MovieDetailTableViewDataSource.tvShowCases
        let voteAvg = response.voteAverage.roundToPlaces(places: 1)
        let listVideos = response.videos.video
        self.configHeaderView(response)
        if response.createdBy.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .actors})
        }
        self.data.updateValue(response.createdBy, forKey: "\(MovieDetailTableViewDataSource.actors)")
        self.data.updateValue(response.videos, forKey: "\(MovieDetailTableViewDataSource.videos)")
        self.data.updateValue(listVideos.map({CommonUtil.getThumbnailYoutubeUrl($0.key)}), forKey: "\(MovieDetailTableViewDataSource.images)")
        self.data.updateValue((totalVote: response.popularity, voteAvg: voteAvg), forKey: "\(MovieDetailTableViewDataSource.notes)")
        self.data.updateValue(response.recommendations.results, forKey: "\(MovieDetailTableViewDataSource.trending)")
        self.data.updateValue([], forKey: "\(MovieDetailTableViewDataSource.rate(hasRate: false))")
        self.data.updateValue(response.reviews.results, forKey: "\(MovieDetailTableViewDataSource.rate(hasRate: true))")
        self.data.updateValue([response.overview], forKey: "\(MovieDetailTableViewDataSource.overview)")
        self.data.updateValue(response.seasons, forKey: "\(MovieDetailTableViewDataSource.season)")
        self.tableView.reloadData()
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        self.tableViewDataSource = MovieDetailTableViewDataSource.movieCases
        let voteAvg = response.voteAverage.roundToPlaces(places: 1)
        let listVideos = response.videos.video
        self.configHeaderView(response)
        if response.credits.cast.isEmpty {
            self.tableViewDataSource.removeAll(where: {$0 == .actors})
        }
        self.data.updateValue(response.credits.cast, forKey: "\(MovieDetailTableViewDataSource.actors)")
        self.data.updateValue(response.videos, forKey: "\(MovieDetailTableViewDataSource.videos)")
        self.data.updateValue(listVideos.map({CommonUtil.getThumbnailYoutubeUrl($0.key)}), forKey: "\(MovieDetailTableViewDataSource.images)")
        self.data.updateValue((totalVote: response.popularity, voteAvg: voteAvg), forKey: "\(MovieDetailTableViewDataSource.notes)")
        self.data.updateValue(response.recommendations.results, forKey: "\(MovieDetailTableViewDataSource.trending)")
        self.data.updateValue([], forKey: "\(MovieDetailTableViewDataSource.rate(hasRate: false))")
        self.data.updateValue(response.reviews.results, forKey: "\(MovieDetailTableViewDataSource.rate(hasRate: true))")
        self.data.updateValue([response.overview], forKey: "\(MovieDetailTableViewDataSource.overview)")
        self.tableView.reloadData()
    }
    
    func fetchRealmMovieDetailObjectWithId(_ object: MovieDetailObject) {
        self.isFavorite = true
    }
    
    func fetchMyReview(_ review: ReviewsResultObject) {
        
    }
    
    func didDeleteMovieObject() {
        self.isFavorite = false
    }
    
    func didInsertMovieObject() {
        self.isFavorite = true
    }
    
    func handleError(_ error: Error) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchMovieDetailObjectWatchedListWithId(_ object: WatchedListObject?) {
        if let _ = object {
            btnWatchedList.backgroundColor = UIColor(hex: "#09BB00")
            btnWatchedList.setImage(UIImage(named: "ic_check"), for: .normal)
        }
        watchedListObject = object
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let baseCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            baseCell.listPayload = data
            baseCell.didTapActionInCell = { [weak self] any in
                guard let `self` = self else { return }
                switch item {
                case .actors:
                    if let actor = any as? Cast {
                        self.presenter.didTapPeople(actor.id)
                    }
                case .trending:
                    if let movie = any as? Movie {
                        self.presenter.didTapMovie(movie)
                    }
                case .rate(hasRate: false):
                    self.presenter.didTapAddnote()
                default:
                    return
                }
            }
        }
        
        if let cell = cell as? MovieVideosTableViewCell, let data = self.data["\(item)"] as? Videos  {
            cell.configCell(data, selectedIndex: self.selectedIndex)
            cell.didTapActionInCell = { [weak self] any in
                guard let `self` = self else { return }
                if let video = any as? Video {
                    self.presenter.didTapPlayVideo(video)
                } else if let selectedIndex = any as? Int {
                    self.selectedIndex = selectedIndex
                }
            }
        }
        
        if let cell = cell as? NotesTableViewCell, let data = self.data["\(item)"] as? (totalVote: Double, voteAvg: Double)  {
            cell.configCell(totalVote: data.totalVote, voteAvg: data.voteAvg)
            cell.didTapActionInCell = { [weak self] _ in
                guard let `self` = self else { return }
                self.presenter.didTapAddnote()
            }
        }
        
        if let cell = cell as? TextExpandTableViewCell  {
            cell.configGradientLayer()
            cell.didTapActionInCell = { [weak self] any in
                guard let `self` = self else { return }
                self.isExpandTextView = !self.isExpandTextView
                UIView.setAnimationsEnabled(false)
                tableView.reloadSections(IndexSet([1]), with: .none)
                UIView.setAnimationsEnabled(true)
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = tableViewDataSource[section]
        let titleHeader = item.titleOfHeader()
        return titleHeader.isEmpty ? 0 : 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = tableViewDataSource[indexPath.section]
        if item == .overview, isExpandTextView {
            return UITableView.automaticDimension
        }
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
    func headerView(_ customHeader: UITableViewHeaderFooterView, didTapButtonInSection section: Int) {
        let item = tableViewDataSource[section]
        switch item {
        case .notes, .rate(hasRate: false):
            presenter.didTapUserNote()
        default:
            return
        }
    }
}

extension MovieDetailViewController: BackFromNextHandleable {
    func showToastAlert() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.viewToast.alpha = 1
        }, completion: {_ in
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn, animations: {
                self.viewToast.alpha = 0
            })
        })
    }
    
    func onBackFromNext(_ result: Any?) {
        if let _ = result as? WatchedListObject {
            self.showToastAlert()
            btnWatchedList.backgroundColor = UIColor(hex: "#09BB00")
            btnWatchedList.setImage(UIImage(named: "ic_check"), for: .normal)
        }
    }
}
