//
//  FavoriteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var filmNoteView: FilmNoteView!
    var didTapRemove: VoidCallBack?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        filmNoteView.viewRemove.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.didTapRemove?()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
