//
//  TVShowViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 21/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class TVShowViewController: BaseViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TVShowTopUpTableViewCell.self, forCellReuseIdentifier: TVShowTopUpTableViewCell.className)
        tableView.register(TVShowPopularTableViewCell.self, forCellReuseIdentifier: TVShowPopularTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
        viewLayer.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight + 20, right: 0)
    }
    
}

// MARK: - TVShowViewInterface
extension TVShowViewController: TVShowViewInterface {
    func getTVShowLastest(_ response: MovieResponse) {
        let listMovie = response.results
//        let first5 = Array(listMovie.prefix(5))
        self.data.updateValue(listMovie, forKey: "\(TVShowTableViewDataSource.topUp)")
        tableView.reloadSections(IndexSet([0]), with: .none)
        self.configMovieDetail(listMovie.first!)
    }
    
    func getGenresList(_ response: GenreResponse) {
        
    }
    
    func getTopRate(_ response: MovieResponse) {
        self.data.updateValue(response.results, forKey: "\(TVShowTableViewDataSource.trending)")
        tableView.reloadSections(IndexSet([2]), with: .none)
    }
    
    func getTVShowPopular(_ response: MovieResponse) {
        self.data.updateValue(response.results, forKey: "\(TVShowTableViewDataSource.popular)")
        tableView.reloadSections(IndexSet([1]), with: .none)
    }
}


extension TVShowViewController: UITableViewDataSource, UITableViewDelegate {
    fileprivate func configMovieDetail(_ movie: Movie) {
        self.imgBackGround.kf.setImage(with: URL(string: "\(baseURLImage)\(movie.posterPath)"))
        self.lbTitle.text = movie.name
        self.lbVoteAvg.text = "\(movie.voteAverage)"
        self.lbYear.text = CommonUtil.getYearFromDate(movie.releaseDate)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let baseCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            baseCell.listPayload = data
            baseCell.didTapActionInCell = { payload in
                switch item {
                case .topUp:
                    if let movie = payload as? Movie {
                        self.configMovieDetail(movie)
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
