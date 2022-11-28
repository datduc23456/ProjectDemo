//
//  HomeViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class HomeViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
	var presenter: HomePresenterInterface!
    var tableViewDataSource: [HomeTableViewDataSource] = HomeTableViewDataSource.allCases
    var data: [String: Any] = [:]
    var storedOffset: CGFloat = 0
    
    override func viewDidLoad() {
        tableView.register(TopRatingTableViewCell.self, forCellReuseIdentifier: TopRatingTableViewCell.className)
        tableView.register(CinemaPopularTableViewCell.self, forCellReuseIdentifier: CinemaPopularTableViewCell.className)
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.registerCell(for: PageCinemaTableViewCell.className)
        tableView.registerCell(for: NewMovieTableViewCell.className)
        tableView.registerCell(for: GengesListTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionFooterHeight = 0
        tableView.bounces = false
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.imgSearch.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.presenter.didTapSearch()
        }
        navigation.configContentNav(.home)
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear(animated)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: AppDelegate.shared.appRootViewController.customTabbarHeight, right: 0)
    }
}

// MARK: - HomeViewInterface
extension HomeViewController: HomeViewInterface {
    func getMoviePopular(_ response: MovieResponse) {
        let listMovie = response.results
        let first8 = Array(listMovie.prefix(8))
        self.data.updateValue(response.results, forKey: "\(HomeTableViewDataSource.popular)")
        self.data.updateValue(first8, forKey: "\(HomeTableViewDataSource.pageView)")
        tableView.reloadSections(IndexSet([2]), with: .none)
        tableView.reloadSections(IndexSet([1]), with: .none)
    }
    
    func getGenresList(_ response: GenreResponse) {
        let genres = [Genre()] + response.genres
        self.data.updateValue(genres, forKey: "\(HomeTableViewDataSource.genges)")
        tableView.reloadData()
    }
    
    func getTopRate(_ response: MovieResponse) {
        let listMovie = response.results
        let first5 = Array(listMovie.prefix(5))
        var cut : ArraySlice<Movie> = []
        cut = listMovie[5 ..< listMovie.endIndex]
        self.data.updateValue(first5, forKey: "\(HomeTableViewDataSource.topRating)")
        self.data.updateValue(Array(cut), forKey: "\(HomeTableViewDataSource.trending)")
        tableView.reloadSections(IndexSet([4]), with: .none)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GengesListTableViewCell.className, for: indexPath) as! GengesListTableViewCell
            cell.collectionView.collectionViewLayout.invalidateLayout()
            if let data = self.data["\(item)"] as? [Genre] {
                let first4 = Array(data.prefix(4))
                cell.payload = first4
            }
            return cell
        }
        
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let baseCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            baseCell.listPayload = data
            baseCell.didTapActionInCell = { [weak self] any in
                guard let `self` = self else { return }
                switch item {
                case .popular, .topRating, .trending, .pageView:
                    self.presenter.didTapToMovie(any as! Movie)
                default:
                    break
                }
            }
        }
        
        if item == .newMovie, let movieCell = cell as? NewMovieTableViewCell {
            movieCell.configGradientLayer()
        }
        return cell
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

extension HomeViewController: HeaderViewDelegate {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int) {
        print("did tap button", section)
    }
}
