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
    @IBInspectable var isAllowToOpenImage: Bool = false
    var didTapImage: ((Int) -> Void)?
    var didAdditionImage: VoidCallBack?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func selected(_ containerView: UIView) {
        containerView.borderWidth = 1
        containerView.borderColor = CHOOSE_GENRE_COLOR
    }
    
    func unselected(_ containerView: UIView) {
        containerView.borderWidth = 0
    }
    
    func configView(_ imageUrl: [URL] = [], selectedIndex: Int = 0, isAdditionImage: Bool = false) {
        for subViews in self.subviews {
            subViews.removeFromSuperview()
        }
        let indexAddition: Int = isAdditionImage && (imageUrl.count < count) ? imageUrl.count : -1
        for index in 0..<count {
            let imageView = AYImageView(frame: .zero)
            imageView.currentViewController = AppDelegate.shared.appRootViewController
            imageView.imageContentMode = .scaleAspectFill
            imageView.placeHolderImage = UIImage(named: "placeholder")
            imageView.isAllowToOpenImage = self.isAllowToOpenImage
            imageView.cornerRadius = 8
            imageView.addTapGestureRecognizer(action: { [weak self] in
                guard let `self` = self else { return }
                if let _ = imageUrl[safe: index] {
                    for view in self.arrangedSubviews {
                        self.unselected(view)
                    }
                    self.selected(imageView)
                    self.didTapImage?(index)
                }
            })
            if let url = imageUrl[safe: index] {
                imageView.setImageFromUrl(url: url.absoluteString)
            }
            
            if index == selectedIndex {
                self.selected(imageView)
            }
            if index == indexAddition {
                imageView.imageContentMode = .scaleToFill
                imageView.setImage(UIImage(named: "Group 2196")!)
                
                imageView.addTapGestureRecognizer {
                    self.didAdditionImage?()
                }
            }
            self.addArrangedSubview(imageView)
        }
    }
}
