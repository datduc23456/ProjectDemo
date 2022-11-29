//
//  PopularPeopleViewController.swift
//  ProjectDemo
//
//  Created by đạt on 25/11/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class PopularPeopleViewController: BaseViewController {
    //BaseCollectionViewController<PeoplePopularCollectionViewCell> {

    @IBOutlet weak var tableViewheight: NSLayoutConstraint!
    @IBOutlet weak var lbTotalFilm: UILabel!
    @IBOutlet weak var lbPob: UILabel!
    @IBOutlet weak var lbDob: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: TableViewAdjustedHeight!
    @IBOutlet weak var scrollView: UIScrollView!
    // MARK: - Properties
	var presenter: PopularPeoplePresenterInterface!
    var tableViewDataSource: [PeopleTableViewDataSource] = PeopleTableViewDataSource.allCases
    var data: [String: Any] = [:]
    var isExpandTextView: Bool = false
    var selectedIndex: Int = 0
    var peopleDetail: PeopleDetail?
    
//    override var heightForItem: Double {
//       return 150
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.className)
        tableView.register(ImagesTableViewCell.self, forCellReuseIdentifier: ImagesTableViewCell.className)
        tableView.registerCell(for: TextExpandTableViewCell.className)
        tableView.registerCell(for: MovieVideosTableViewCell.className)
        tableView.register(UINib(nibName: HeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentSizeDelegate = self
        scrollView.showsVerticalScrollIndicator = false
        self.btnBack.addTapGestureRecognizer {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! PeoplePopularCollectionViewCell
//        return cell
//    }
}

// MARK: - PopularPeopleViewInterface
extension PopularPeopleViewController: PopularPeopleViewInterface {
    var id: Int {
        if let id = payload as? Int {
            return id
        }
        return 0
    }

    func configHeaderView(_ response: PeopleDetail) {
//        let listVideos = response.videos.video
//        if listVideos.isEmpty {
//            self.tableViewDataSource.removeAll(where: {$0 == .videos || $0 == .images})
//        }
//        if response.recommendations.results.isEmpty {
//            self.tableViewDataSource.removeAll(where: {$0 == .trending})
//        }
//        if response.seasons.isEmpty {
//            self.tableViewDataSource.removeAll(where: {$0 == .season})
//        }
//        if response.overview.isEmpty {
//            self.tableViewDataSource.removeAll(where: {$0 == .overview})
//        }
        self.peopleDetail = response
        avatar.kf.setImage(with: URL(string: "\(baseURLImage)\(response.profilePath)"))
//        imgBackDrop.kf.setImage(with: URL(string: "\(baseURLImage)\(response.)"))
        lbDob.text = "Date of birth: \(response.birthday.toDateFormat(toFormat: "MMM dd, yyyy"))"
        lbPob.text = "Place of birth: \(response.placeOfBirth)"
        lbName.text = response.name
        lbTotalFilm.text = "Total Films: \(response.tvCredits.cast.count + response.tvCredits.crew.count + response.movieCredits.cast.count + response.movieCredits.crew.count)"
//        lbGenres.text = DTPBusiness.shared.mapToGenreName(response.genres.map({$0.id}))
    }
    
    
    func getPeopleDetail(_ people: PeopleDetail) {
        self.configHeaderView(people)
//        self.data.updateValue(response.createdBy, forKey: "\(MovieDetailTableViewDataSource.actors)")
//        self.data.updateValue(response.videos, forKey: "\(MovieDetailTableViewDataSource.videos)")
        self.data.updateValue(people.images.profile.map({$0.filePath}), forKey: "\(PeopleTableViewDataSource.images)")
//        self.data.updateValue((totalVote: response.popularity, voteAvg: voteAvg), forKey: "\(MovieDetailTableViewDataSource.notes)")
//        self.data.updateValue(response.recommendations.results, forKey: "\(MovieDetailTableViewDataSource.trending)")
//        self.data.updateValue(response.reviews.results, forKey: "\(MovieDetailTableViewDataSource.rate)")
        self.data.updateValue([people.biography], forKey: "\(PeopleTableViewDataSource.overview)")
//        self.data.updateValue(response.seasons, forKey: "\(MovieDetailTableViewDataSource.season)")
        self.tableView.reloadData()
    }
}

extension PopularPeopleViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension PopularPeopleViewController: TableViewAdjustedHeightDelegate {
    func didChangeContentSize(_ tableView: TableViewAdjustedHeight, size contentSize: CGSize) {
        tableViewheight.constant = tableView.contentSize.height
        self.view.layoutIfNeeded()
    }
}

extension PopularPeopleViewController: HeaderViewDelegate {
    func headerView(_ customHeader: HeaderView, didTapButtonInSection section: Int) {
        print("did tap button", section)
    }
}
