//
//  NewMovieTableViewCell.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 18/11/2022.
//

import UIKit

class NewMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    var gradientLayer: CAGradientLayer!
    var didTapSeeMore: VoidCallBack?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func seeMoreAction(_ sender: Any) {
        self.didTapSeeMore?()
    }
    
    func configGradientLayer() {
        if gradientLayer == nil {
            let colorTop =  UIColor.init(hex: "#98403C").cgColor
            let colorBottom = UIColor.init(hex: "#741D3F").cgColor
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [colorTop, colorBottom]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.frame = CGRect(x: 0, y: 0, width: 343, height: 192)
            gradientLayer.cornerRadius = 8
            gradientLayer.position = contentView.center
            contentView.layer.insertSublayer(gradientLayer, at:0)
            self.gradientLayer = gradientLayer
        }
    }
}
