//
//  MovieVideosTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class MovieVideosTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    
    @IBOutlet weak var lbPublished: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var stackView: ImageStackView!
    
    var selectedIndex: Int = 0
    var listPayload: [Any] = []
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    var videos: Videos?
    var video: Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
            imgThumbnail.kf.setImage(with: CommonUtil.getThumbnailYoutubeUrl(video.key))
            lbName.text = video.name
            lbPublished.text = video.publishedAt.toDateFormat(toFormat: "MMM dd, yyyy")
        }
    }
    
    func configCell(_ videos: Videos, selectedIndex: Int = 0) {
        self.videos = videos
        self.selectedIndex = selectedIndex
        if let firstVideo = videos.video.first {
            self.video = firstVideo
            imgThumbnail.kf.setImage(with: CommonUtil.getThumbnailYoutubeUrl(firstVideo.key))
            lbName.text = firstVideo.name
            lbPublished.text = firstVideo.publishedAt.toDateFormat(toFormat: "MMM dd, yyyy")
            let stackViewVideos = videos.video
            stackView.configView(stackViewVideos.map({CommonUtil.getThumbnailYoutubeUrl($0.key)}), selectedIndex: selectedIndex)
        }
    }
    
}
