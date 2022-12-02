//
//  GengesCollectionViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 17/11/2022.
//

import UIKit
import Kingfisher

class GengesCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var viewBackgroundImage: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    var isHeightCalculated: Bool = false
    var genre: Genre!
    var isSelect: Bool = false {
        didSet {
            if self.isSelect {
                self.selected()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer(action: {
            if !self.isSelect, let genre = self.genre {
                self.didTapAction?(genre)
                self.isSelect = true
            }
        })
    }
    
    override func prepareForReuse() {
        
    }
    
    override func configCell(_ payload: Any) {
        if let payload = payload as? Genre {
            self.genre = payload
            lbTitle.text = payload.name
            image.image = UIImage(named: payload.name)
        }
    }
    
    func configCell(_ payload: Any, isSelected: Bool) {
        self.configCell(payload)
        self.isSelect = isSelected
        if isSelected {
            selected()
        } else {
            unsected()
        }
    }
    
    func selected() {
        DTPBusiness.shared.genreSelectedId = genre.id
        viewBackgroundImage.backgroundColor = .white
        image.tintColor = CHOOSE_GENRE_COLOR
        lbTitle.textColor = .black
        contentView.backgroundColor = CHOOSE_GENRE_COLOR
    }
    
    func unsected() {
        viewBackgroundImage.backgroundColor = .black
        image.tintColor = .white
        lbTitle.textColor = .white
        contentView.backgroundColor = CONTENT_CELL_COLOR
    }
}

extension String {
    // hàm tính chiều dài string theo hàng dọc
    func estimateHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    // hàm tính chiều dài string theo hàng ngang
    func estimateWidth(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
