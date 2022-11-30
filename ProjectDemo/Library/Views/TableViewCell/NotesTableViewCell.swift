//
//  NotesTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var listPayload: [Any] = []
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    

    @IBOutlet weak var lbTotalVote: UILabel!
    @IBOutlet weak var lbVoteAvg: UILabel!
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
    
    func configCell(totalVote: Double, voteAvg: Double) {
        lbTotalVote.text = "\(totalVote) rating"
        lbVoteAvg.text = "\(voteAvg)"
    }
}
