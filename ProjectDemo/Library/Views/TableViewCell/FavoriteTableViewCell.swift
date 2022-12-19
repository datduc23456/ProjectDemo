//
//  FavoriteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    
    @IBOutlet weak var filmNoteView: FilmNoteView!
    var didTapRemove: VoidCallBack?
    var listPayload: [Any] = []
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        filmNoteView.btnProperties.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.didTapRemove?()
        }
        contentView.addTapGestureRecognizer { [weak self] in
            guard let `self` = self else { return }
            self.didTapActionInCell(0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
