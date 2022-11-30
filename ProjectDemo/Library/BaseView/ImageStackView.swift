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
    var didTapImage: ((Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func selected(_ imageView: UIImageView) {
        imageView.borderWidth = 1
        imageView.borderColor = CHOOSE_GENRE_COLOR
    }
    
    func unselected(_ imageView: UIImageView) {
        imageView.borderWidth = 0
    }
    
    func configView(_ imageUrl: [URL] = [], selectedIndex: Int = 0) {
        self.layoutIfNeeded()
        for subViews in self.subviews {
            self.removeArrangedSubview(subViews)
        }
        let spacingCount: CGFloat = CGFloat(count - 1) * spacing
        let width: CGFloat = (self.frame.width - spacingCount) / CGFloat(count)
        for index in 0..<count {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.cornerRadius = 8
            imageView.snp.makeConstraints {
                $0.width.equalTo(width)
            }
            imageView.addTapGestureRecognizer(action: { [weak self] in
                guard let `self` = self else { return }
                for view in self.arrangedSubviews {
                    if let imageV = view as? UIImageView {
                        self.unselected(imageV)
                    }
                }
                self.selected(imageView)
                self.didTapImage?(index)
            })
            if let url = imageUrl[safe: index] {
                imageView.setImageUrlWithPlaceHolder(url: url)
            }
            if index == selectedIndex {
                self.selected(imageView)
            }
            self.addArrangedSubview(imageView)
        }
    }
}
