//
//  PageCinemaTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 18/11/2022.
//

import UIKit

class PageCinemaTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    
    var collectionView: BaseCollectionView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var backGroundImg: UIImageView!
    @IBOutlet weak var pageControl: FSPageControl!
    @IBOutlet weak var pagerView: FSPagerView!
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    var listPayload: [Any] = [] {
        didSet {
            pageControl.numberOfPages = listPayload.count
            if !listPayload.isEmpty, let firstMovie = listPayload.first as? Movie  {
                configCell(firstMovie)
            }
            pagerView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pagerView.itemSize = CGSize(width: 306, height: 221)
        pagerView.interitemSpacing = 50
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.bounces = false
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pagerView.backgroundColor = .clear
        pageControl.numberOfPages = 5
        pageControl.backgroundColor = .clear
        pageControl.setFillColor(.white, for: .normal)
        pageControl.setFillColor(UIColor(hex: "#BF5958"), for: .selected)
        let blurEffect = UIBlurEffect.init(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.2
        blurEffectView.frame = contentView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.insertSubview(blurEffectView, at: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(_ movie: Movie) {
        backGroundImg.kf.setImage(with: URL(string: "\(baseURLImage)\(movie.backdropPath)"))
        lbTitle.text = movie.originalTitle
        lbRate.text = "\(movie.voteAverage)"
        lbYear.text = CommonUtil.getYearFromDate(movie.releaseDate)
        lbGenre.text = DTPBusiness.shared.mapToGenreName(movie.genreIDS)
    }
}

extension PageCinemaTableViewCell: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return listPayload.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let movie = listPayload[index] as! Movie
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: "\(baseURLImage)\(movie.backdropPath)"))
        cell.imageView?.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.didTapActionInCell(movie)
        }
        cell.textLabel?.superview?.isHidden = true
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
        let movie = listPayload[targetIndex] as! Movie
        configCell(movie)
    }
}
