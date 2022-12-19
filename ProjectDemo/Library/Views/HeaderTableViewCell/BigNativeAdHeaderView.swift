//
//  BigNativeAdHeaderView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 13/12/2022.
//

import UIKit

class BigNativeAdHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var bigNativeadView: BigNativeAdView!
    static let reuseIdentifier = "BigNativeAdHeaderView"
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        bigNativeadView.register(id: "ca-app-pub-3940256099942544/3986624511")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bigNativeadView.register(id: "ca-app-pub-3940256099942544/3986624511")
    }
}
