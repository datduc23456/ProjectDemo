//
//  TextExpandTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 26/11/2022.
//

import UIKit

class TextExpandTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    
    var listPayload: [Any] = [] {
        didSet {
            self.configCell()
        }
    }
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.addTapGestureRecognizer {
            self.didTapActionInCell(())
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configGradientLayer() {
        if gradientLayer == nil {
            let colorTop =  UIColor.init(hex: "#0D1015").withAlphaComponent(0).cgColor
            let colorBottom = UIColor.init(hex: "#0D1015").cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorBottom, colorTop]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(x: 0, y: self.contentView.bounds.height - 53, width: CommonUtil.SCREEN_WIDTH, height: 53)
            gradientLayer.position = contentView.center
            contentView.layer.insertSublayer(gradientLayer, at:0)
            self.gradientLayer = gradientLayer
        }
    }
    
    func removeGradientLayer() {
        if gradientLayer != nil {
            gradientLayer.removeFromSuperlayer()
        }
    }
    
    func configCell() {
        if let overview = self.listPayload.first as? String {
            self.textView.text = overview
        }
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        let sizeThatShouldFitTheContent = textView.sizeThatFits(textView.frame.size)
        let height = sizeThatShouldFitTheContent.height
        return CGSize.init(width: targetSize.width, height: height)
    }
}
