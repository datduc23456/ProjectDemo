//
//  UserNoteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 28/11/2022.
//

import UIKit

class UserNoteTableViewCell: UITableViewCell {
    
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
    
}
