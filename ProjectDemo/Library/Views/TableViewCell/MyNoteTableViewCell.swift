//
//  UserNoteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//

import UIKit

class MyNoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var filmNoteView: FilmNoteView!
    @IBOutlet weak var ic_edit: UIImageView!
    var didTapEdit: VoidCallBack?
    override func awakeFromNib() {
        super.awakeFromNib()
        btnMore.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.didTapEdit?()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ data: ReviewsResultObject) {
        lbName.text = data.author
        filmNoteView.lbGenre.text = DTPBusiness.shared.mapToGenreName(Array(data.genreIDS))
        filmNoteView.lbDate.text = "Watched " + data.updatedAt.toDateFormat(toFormat: "dd MMM yyyy")
        filmNoteView.lbTitle.text = !data.originalTitle.isEmpty ? data.originalTitle : data.originalName
        filmNoteView.lbRating.text = "\((data.authorDetails?.rating).isNil(value: 0.0))"
        filmNoteView.img.setImageUrlWithPlaceHolder(url: URL(string: "\(baseURLImage)\(data.posterPath)"))
        filmNoteView.viewRemove.isHidden = true
        filmNoteView.viewVoteAvg.isHidden = true
        lbContent.text = data.content
    }
    
}
