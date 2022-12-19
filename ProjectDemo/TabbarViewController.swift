//
//  TabbarViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 16/11/2022.
//

import UIKit

class TabbarItem: UIView {
    var index: Int!
    var selectedAction: VoidCallBack!
    var imageView: UIImageView!
    
    init(frame: CGRect, index: Int, selectedAction: @escaping VoidCallBack) {
        super.init(frame: frame)
        self.index = index
        self.selectedAction = selectedAction
        let imageView = UIImageView.init(image: UIImage(named: "ic_tabbar\(index+1)"))
        self.imageView = imageView
        self.addSubview(imageView)
        imageView.center = self.center
        self.addTapGestureRecognizer(action: { [weak self] in
            guard let `self` = self else { return }
            self.selectedAction()
        })
    }
    
    func selected() {
        self.imageView.image = UIImage(named: "ic_tabbar\(index+1)_selected")
    }
    
    func unselected() {
        self.imageView.image = UIImage(named: "ic_tabbar\(index+1)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TabbarViewController: UITabBarController {
    
    let customTabbarHeight: CGFloat = 54
    var listVc: [UIViewController] = [AppScreens.statistical.createViewController(), AppScreens.tvShow.createViewController(), AppScreens.home.createViewController(), AppScreens.favorite.createViewController(), AppScreens.note.createViewController()]
    var countVc: Int {
        return listVc.count
    }
    var items: [TabbarItem] = []
    var customTabbar: UIStackView!
    var viewGradientBottom: UIView!
    var gradient: CAGradientLayer!
    var isFirstLayout: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = APP_COLOR
        self.viewControllers = listVc
        self.setupGradientTabbar()
        var height: CGFloat = 10
        if let safeAreaInsets = AppDelegate.shared.window?.safeAreaInsets.bottom, safeAreaInsets != 0 {
            height = 0
        }
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.borderWidth = 1
        stackView.borderColor = UIColor(hex: "#3F4249")
        stackView.backgroundColor = UIColor(hex: "#191C23")
        stackView.cornerRadius = 16
        let frame = CGRect(x: 0, y: 0, width: (CommonUtil.SCREEN_WIDTH - 32) / CGFloat(countVc), height: customTabbarHeight)
        self.view.addSubview(stackView)
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -AppDelegate.shared.window!.safeAreaInsets.bottom - height).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: customTabbarHeight).isActive = true
        for (index, _) in self.tabBar.items!.enumerated() {
            let tabbarItem = TabbarItem(frame: frame, index: index, selectedAction: {})
            stackView.addArrangedSubview(tabbarItem)
            tabbarItem.translatesAutoresizingMaskIntoConstraints = false
            tabbarItem.widthAnchor.constraint(equalToConstant: (CommonUtil.SCREEN_WIDTH - 32) / CGFloat(countVc)).isActive = true
            tabbarItem.selectedAction = { [weak self] in
                guard let `self` = self else { return }
                self.unselectAll()
                tabbarItem.selected()
                self.selectedViewController = self.listVc[index]
            }
            self.items.append(tabbarItem)
        }
        
        self.items[2].selectedAction()
        
//        for item in self.viewControllers ?? [] {
//
//            var inset = item.view.safeAreaInsets
//            inset.bottom = customTabbarHeight
//            item.additionalSafeAreaInsets = inset
//        }
        self.customTabbar = stackView
        self.tabBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstLayout {
            viewGradientBottom.fadeView(style: .top, percentage: 0.55)
            isFirstLayout = !isFirstLayout
            NotificationCenter.default.addObserver(self, selector: #selector(showOpenAds), name: Notification.Name("AppOpenAdDidLoad"), object: nil)
        }
//        gradient.frame = viewGradientBottom.bounds
    }
    
    @objc func showOpenAds() {
        AdMobManager.shared.show(key: "AppOpenAd")
    }
    
    func unselectAll() {
        for item in items {
            item.unselected()
        }
    }
    
    func setupGradientTabbar() {
        viewGradientBottom = UIView()
        view.addSubview(viewGradientBottom)
        viewGradientBottom.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(customTabbarHeight + AppDelegate.shared.window!.safeAreaInsets.bottom + 30)
        }
        gradient = CAGradientLayer()
//        gradient.frame = viewGradientBottom.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0, 1]
//        viewGradientBottom.fadeView(style: .bottom)
//        viewGradientBottom.layer.mask = gradient
        viewGradientBottom.backgroundColor = APP_COLOR
    }
    
}
