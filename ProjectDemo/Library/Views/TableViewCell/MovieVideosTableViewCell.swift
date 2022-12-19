//
//  MovieVideosTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class MovieVideosTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var collectionView: BaseCollectionView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var icPlay: UIImageView!
    @IBOutlet weak var lbPublished: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var stackView: ImageStackView!
    
    var selectedIndex: Int = 0
    var listPayload: [Any] = []
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    var videos: Videos?
    var video: Video?
    var movies: [Movie]?
    var movie: Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom == .pad {
            stackViewHeight.constant = 120
        }
        stackView.didTapImage = { [weak self] index in
            guard let `self` = self else { return }
            self.selectedIndex = index
            self.tapToStackView(index)
            self.didTapActionInCell(index)
        }
        imgThumbnail.addTapGestureRecognizer { [weak self] in
            guard let `self` = self, let video = self.video else { return }
            self.didTapActionInCell(video)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func tapToStackView(_ index: Int) {
        if let video = videos?.video[safe: index] {
            self.video = video
            imgThumbnail.setImageUrlWithPlaceHolder(url: CommonUtil.getThumbnailYoutubeUrl(video.key))
            lbName.text = video.name
            lbPublished.text = video.publishedAt.toDateFormat(toFormat: "MMM dd, yyyy")
        } else if let movie = movies?[safe: index] {
            imgThumbnail.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(movie.posterPath)"))
            lbName.text = !movie.originalTitle.isEmpty ? movie.originalTitle : movie.originalName
            lbPublished.text = !movie.releaseDate.isEmpty ? movie.releaseDate.toDateFormat(toFormat: "MMM dd, yyyy") : movie.firstAirDate.toDateFormat(toFormat: "MMM dd, yyyy")
        }
    }
    
    func configCell(_ videos: Videos, selectedIndex: Int = 0) {
        self.videos = videos
        self.selectedIndex = selectedIndex
        if let firstVideo = videos.video.first {
            self.video = firstVideo
            imgThumbnail.setImageUrlWithPlaceHolder(url: CommonUtil.getThumbnailYoutubeUrl(firstVideo.key))
            lbName.text = firstVideo.name
            lbPublished.text = firstVideo.publishedAt.toDateFormat(toFormat: "MMM dd, yyyy")
            let stackViewVideos = videos.video
            stackView.configView(stackViewVideos.map({CommonUtil.getThumbnailYoutubeUrl($0.key)}), selectedIndex: selectedIndex)
        }
    }
    
    func configCell(_ movies: [Movie], selectedIndex: Int = 0) {
        self.movies = movies
        self.selectedIndex = selectedIndex
        self.icPlay.isHidden = true
        if let firstMovie = movies.first {
            self.movie = firstMovie
            imgThumbnail.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(firstMovie.backdropPath)"))
            lbName.text = !firstMovie.originalTitle.isEmpty ? firstMovie.originalTitle : firstMovie.originalName
            lbPublished.text = !firstMovie.releaseDate.isEmpty ? firstMovie.releaseDate.toDateFormat(toFormat: "MMM dd, yyyy") : firstMovie.firstAirDate.toDateFormat(toFormat: "MMM dd, yyyy")
            let stackViewMovies = movies
            stackView.configView(stackViewMovies.map({URL(string: "\(baseURLImage)\($0.backdropPath)")!}), selectedIndex: selectedIndex)
        }
    }
}
