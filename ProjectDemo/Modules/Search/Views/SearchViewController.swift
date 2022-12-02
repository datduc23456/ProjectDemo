//
//  SearchViewController.swift
//  ProjectDemo
//
//  Created by đạt on 27/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

enum SearchType {
    case detail
    case addnote
    case watchedlist
}

final class SearchViewController: BaseViewController {

    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var presenter: SearchPresenterInterface!
    var delayValue : Double = 2.0
    var timer:Timer?
    var tableViewDataSource: [SearchViewDataSource] = SearchViewDataSource.emptyCases
    var data: [String: Any] = [:]
    var keyStore: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.register(CinemaPopularTableViewCell.self, forCellReuseIdentifier: CinemaPopularTableViewCell.className)
        tableView.register(TVShowPopularTableViewCell.self, forCellReuseIdentifier: TVShowPopularTableViewCell.className)
        tableView.register(PeoplePopularTableViewCell.self, forCellReuseIdentifier: PeoplePopularTableViewCell.className)
        tableView.register(GenresSearchTableViewCell.self, forCellReuseIdentifier: GenresSearchTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.registerCell(for: SearchHistoryTableViewCell.className)
        tableView.registerCell(for: GenresSearchTableViewCell.className)
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionHeaderHeight = 0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.showsVerticalScrollIndicator = false
        tableView.bounces = false
        let navigation: BaseNavigationView = initCustomNavigation(.base)
        navigation.configContentNav(.search)
        navigation.btnBack.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
        navigation.textField.addTarget(self, action: #selector(changedTextFieldValue), for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        self.tableView.reloadData()
    }
    
    @objc func changedTextFieldValue(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delayValue, target: self, selector: #selector(self.searchAction), userInfo: nil, repeats: false)
    }
    
    @objc func searchAction() {
        if let myNavigationBar = myNavigationBar as? BaseNavigationView, let query = myNavigationBar.textField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            if !query.isEmpty {
                if !keyStore.contains(where: {$0 == query}) {
                    presenter.didSearch(query)
                }
                tableViewDataSource = SearchViewDataSource.allCases
                presenter.searchPerson(query)
                presenter.searchMoviePopular(query)
                presenter.searchTVShowPopular(query)
            } else {
                tableViewDataSource = SearchViewDataSource.emptyCases
                presenter.fetchSearchKey()
            }
        }
    }
}

// MARK: - SearchViewInterface
extension SearchViewController: SearchViewInterface {
    
    var searchType: SearchType {
        if let searchType = payload as? SearchType {
            return searchType
        }
        return .detail
    }
    
    func fetchSearchKey(_ keys: [SearchKeyObject]) {
        self.keyStore = keys.map({$0.key})
        self.data.updateValue(keys, forKey: "\(SearchViewDataSource.recent)")
        self.data.updateValue(DTPBusiness.shared.listGenres, forKey: "\(SearchViewDataSource.genre)")
        tableView.reloadData()
    }
    
    func searchMoviePopular(_ response: [Movie]) {
        if response.isEmpty {
            tableViewDataSource.removeAll(where: {$0 == .movie})
        } else if tableViewDataSource.filter({$0 == .movie}).first == nil  {
            tableViewDataSource.append(.movie)
        }
        self.data.updateValue(response, forKey: "\(SearchViewDataSource.movie)")
        tableView.reloadData()
    }
    
    func searchTVShowPopular(_ response: [Movie]) {
        if response.isEmpty {
            tableViewDataSource.removeAll(where: {$0 == .tvshow})
        } else if tableViewDataSource.filter({$0 == .tvshow}).first == nil {
            tableViewDataSource.append(.tvshow)
        }
        self.data.updateValue(response, forKey: "\(SearchViewDataSource.tvshow)")
        tableView.reloadData()
    }
    
    func searchPerson(_ response: [Cast]) {
        if response.isEmpty {
            tableViewDataSource.removeAll(where: {$0 == .person})
        } else if tableViewDataSource.filter({$0 == .person}).first == nil {
            tableViewDataSource.append(.person)
        }
        self.data.updateValue(response, forKey: "\(SearchViewDataSource.person)")
        tableView.reloadData()
    }
    
    func getMovieDetail(_ response: MovieDetail) {
        
    }
    
    func getTVShowDetail(_ response: MovieDetail) {
        
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = tableViewDataSource[indexPath.section]
        let T = item.typeOfCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: T.className, for: indexPath)
        cell.selectionStyle = .none
        if let baseCell = cell as? BaseWithCollectionTableViewCellHandler, let data = self.data["\(item)"] as? [Any] {
            baseCell.listPayload = data
            baseCell.didTapActionInCell = { [weak self] payload in
                guard let `self` = self else { return }
                switch item {
                case .person:
                    if let cast = payload as? Cast {
                        self.presenter.didTapToCast(cast)
                    }
                case .movie, .tvshow:
                    if let movie = payload as? Movie {
                        self.presenter.didTapToMovie(movie)
                    }
                case .genre:
                    if let genre = payload as? Genre {
                        if let myNavigationBar = self.myNavigationBar as? BaseNavigationView {
                            myNavigationBar.textField.text = "Genre: \(genre.name)"
                        }
                        self.tableViewDataSource = SearchViewDataSource.allCases
                        self.presenter.searchGenre(genre)
                    }
                case .recent:
                    break
                }
            }
        }
        
        if let cell = cell as? SearchHistoryTableViewCell, let data = self.data["\(item)"] as? [SearchKeyObject] {
            cell.configCell(data[indexPath.row])
            cell.didTapRemove = { [weak self] searchKeyObject in
                guard let `self` = self else { return }
                self.realmUtils.deleteObject(object: searchKeyObject)
                self.presenter.fetchSearchKey()
                tableView.reloadData()
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let item = tableViewDataSource[section]
        if item == .recent, let data = self.data["\(item)"] as? [Any] {
            return data.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = tableViewDataSource[section]
        let titleHeader = item.titleOfHeader()
        if !titleHeader.isEmpty {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            headerView.contentView.backgroundColor = APP_COLOR
            headerView.lbTitle.text = titleHeader
            headerView.btnSeeMore.isHidden = true
            headerView.sectionNumber = section
//            headerView.delegate = self
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let item = tableViewDataSource[section]
        let titleHeader = item.titleOfHeader()
        return titleHeader.isEmpty ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = tableViewDataSource[indexPath.section]
        return item.heightForRow()
    }
}

extension SearchViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "ic_emptySearch")!
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let myNavigationBar = myNavigationBar as? BaseNavigationView, let query = myNavigationBar.textField.text {
            let title = "No search results found \"\(query)\""
            let attributes = [NSAttributedString.Key.font: UIFont(name: "Nexa-Bold", size: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
            return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
        }
        return NSMutableAttributedString(string: "", attributes: [:])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "Please try another keyword"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "NexaRegular", size: 16), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        return NSMutableAttributedString(string: title, attributes: attributes as [NSAttributedString.Key : Any])
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
}
