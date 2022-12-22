//
//  NotesTableViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit

class NotesTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var collectionView: BaseCollectionView!
    
    var listPayload: [Any] = []
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    

    @IBOutlet weak var imageStackView: ImageStackView!
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
    
    func configCell(totalVote: Double, totalReviews: [ReviewsResult]) {
        lbTotalVote.text = "\(totalVote) rating"
        let voteAvg = totalReviews.isEmpty ? 0 : totalReviews.compactMap({$0.authorDetails.rating}).reduce(0.0, +) / Double(totalReviews.count)
        lbVoteAvg.text = "\(voteAvg.roundToPlaces(places: 1))"
        let urls = totalReviews.compactMap({$0.images}).reduce([], +).compactMap({
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return documents.appendingPathComponent($0)
        })
        imageStackView.configView(urls, selectedIndex: -1)
    }
}
