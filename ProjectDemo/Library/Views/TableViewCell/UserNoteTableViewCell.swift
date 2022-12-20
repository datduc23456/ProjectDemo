//
//  UserNoteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//

import UIKit

class UserNoteTableViewCell: UITableViewCell {

    @IBOutlet weak var stackImages: ImageStackView!
    @IBOutlet weak var viewImages: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func congfigCell(_ review: ReviewsResult) {
        lbName.text = review.authorDetails.username.isEmpty ? "You" : review.authorDetails.username
        lbContent.text = review.content
        lbRating.text = "\(review.authorDetails.rating)"
        avatar.setImageUrlWithPlaceHolder(url: URL.init(string: "\(baseURLImage)\(review.authorDetails.avatarPath)"), UIImage(named: "ava_default")!)
        if review.images.isEmpty {
            viewImages.isHidden = true
        } else {
            viewImages.isHidden = false
            let urls = review.images.map({
                let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                return documents.appendingPathComponent($0)
            })
            stackImages.configView(urls, selectedIndex: -1)
        }
    }
}
