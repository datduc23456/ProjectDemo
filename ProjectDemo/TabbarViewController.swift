//
//  TabbarViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 16/11/2022.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [AppScreens.example.createViewController(), AppScreens.example.createViewController()]
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        let view = UIView(frame: CGRect(x: 0, y: 0, width: (AppDelegate.shared.window?.bounds.width)! / 2, height: 84))
        view.backgroundColor = .yellow
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: (AppDelegate.shared.window?.bounds.width)! / 2, height: 84))
        view1.backgroundColor = .blue
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        view.widthAnchor.constraint(equalToConstant: (AppDelegate.shared.window?.bounds.width)! / 2).isActive = true
        view1.widthAnchor.constraint(equalToConstant: (AppDelegate.shared.window?.bounds.width)! / 2).isActive = true
        
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -AppDelegate.shared.window!.safeAreaInsets.bottom).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 84).isActive = true
        stackView.addArrangedSubview(view)
        stackView.addArrangedSubview(view1)
//        stackView.addArrangedSubview()
        self.tabBarController?.tabBar.isHidden = true
        for (index, item) in self.tabBar.items!.enumerated() {
            if index == 0 {
                item.image = UIImage(named: "ic_arrow_back")
            } else {
//                ic_arrow_discount
                item.image = UIImage(named: "ic_arrow_discount")
            }
        }
    }
}
