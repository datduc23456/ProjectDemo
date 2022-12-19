//
//  AddNoteTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 01/12/2022.
//

import UIKit

class AddNoteTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var collectionView: BaseCollectionView!
    var listPayload: [Any] = []
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    

    @IBOutlet weak var viewBackGround: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        self.didTapActionInCell(0)
    }
}
