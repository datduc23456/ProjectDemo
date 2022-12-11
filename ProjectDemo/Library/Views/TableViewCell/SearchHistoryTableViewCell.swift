//
//  SearchHistoryTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 28/11/2022.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var icClose: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var didTapSearch: ((SearchKeyObject) -> Void) = {_ in}
    var didTapRemove: ((SearchKeyObject) -> Void) = {_ in}
    var searchKeyObject: SearchKeyObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        icClose.addTapGestureRecognizer {
            if let searchKeyObject = self.searchKeyObject {
                self.didTapRemove(searchKeyObject)
            }
        }
        lbTitle.addTapGestureRecognizer {
            if let searchKeyObject = self.searchKeyObject {
                self.didTapSearch(searchKeyObject)
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(_ key: SearchKeyObject) {
        self.searchKeyObject = key
        lbTitle.text = key.key
    }
}
