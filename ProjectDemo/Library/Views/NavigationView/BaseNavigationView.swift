//
//  HomeNavigationView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 20/11/2022.
//

import UIKit

enum BaseNavigationType {
    case home
    case navigation
    case search
    case tabbar
    case tvshow
    case filter
}

class BaseNavigationView: NavigationBarView {

    @IBOutlet weak var leadingTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var viewSearch: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var icBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var imgStarMoviee: UIImageView!
    @IBOutlet weak var imgClearSearch: UIImageView!
    @IBOutlet weak var lbPlaceHolder: UILabel!
    @IBOutlet weak var imgFilter: UIImageView!
    
    func configContentNav(_ type: BaseNavigationType) {
        for view in self.subviews {
            view.isHidden = true
        }
        switch type {
        case .home:
            imgSetting.isHidden = false
            imgSearch.isHidden = false
            imgStarMoviee.isHidden = false
        case .tvshow:
            leadingTitleConstraint.constant = -32
            imgSetting.isHidden = false
            imgSearch.isHidden = false
            lbTitle.isHidden = false
        case .tabbar:
            leadingTitleConstraint.constant = -32
            imgSetting.isHidden = false
            imgSearch.isHidden = false
            lbTitle.isHidden = false
        case .navigation:
            lbTitle.isHidden = false
            icBack.isHidden = false
            btnBack.isHidden = false
        case .filter:
            lbTitle.isHidden = false
            icBack.isHidden = false
            btnBack.isHidden = false
            imgFilter.isHidden = false
        case .search:
            icBack.isHidden = false
            btnBack.isHidden = false
            viewSearch.isHidden = false
        }
    }
}
