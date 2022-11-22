//
//  ImageStackView.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit
import SnapKit
import Kingfisher

class ImageStackView: UIStackView {
    
    @IBInspectable var count: Int = 1
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configView() {
        self.layoutIfNeeded()
        for subViews in self.subviews {
            self.removeArrangedSubview(subViews)
        }
        let spacingCount: CGFloat = CGFloat(count - 1) * spacing
        let width: CGFloat = (self.frame.width - spacingCount) / CGFloat(count)
        for _ in 0..<count {
            let imageView = UIImageView()
            imageView.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/od22ftNnyag0TTxcnJhlsu3aLoU.jpg"))
            imageView.contentMode = .scaleAspectFill
            imageView.cornerRadius = 8
            imageView.snp.makeConstraints {
                $0.width.equalTo(width)
            }
            self.addArrangedSubview(imageView)
        }
    }
}
