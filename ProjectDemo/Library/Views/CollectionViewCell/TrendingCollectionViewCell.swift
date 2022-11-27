//
//  TrendingCollectionViewCell.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 17/11/2022.
//

import UIKit

class TrendingCollectionViewCell: BaseCollectionViewCell {

    @IBOutlet weak var imageView: AYImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self, let payload = self.payload else { return }
            self.didTapAction?(payload)
        })
        imageView.borderColor = .clear
        imageView.imageContentMode = .scaleToFill
        imageView.currentViewController = AppDelegate.shared.appRootViewController
    }
    

    override func configCell(_ payload: Any) {
        if let payload = payload as? Movie {
            self.payload = payload
            imageView.isAllowToOpenImage = false
            imageView.setImageFromUrl(url: "\(baseURLImage)\(payload.posterPath)")
        }
        
        if let payload = payload as? URL {
            self.payload = payload
            imageView.setImageFromUrl(url: payload.absoluteString)
        }
    }
    
}
