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
    
    func configCell(totalVote: Double, voteAvg: Double, myReviews: [ReviewsResult]) {
        lbTotalVote.text = "\(totalVote) rating"
        let myReviewsVoteAvg = myReviews.compactMap({$0.authorDetails.rating}).reduce(0.0, +) / Double(myReviews.count)
        let vote = (voteAvg + myReviewsVoteAvg) / 2
        lbVoteAvg.text = "\(vote.roundToPlaces(places: 1))"
        let urls = myReviews.compactMap({$0.images}).reduce([], +).compactMap({
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            return documents.appendingPathComponent($0)
        })
        imageStackView.configView(urls, selectedIndex: -1)
    }
}
