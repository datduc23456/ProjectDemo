//
//  MyStackViewBottomSheetViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 22/11/2022.
//

import UIKit
import SnapKit

class BaseViewBottomSheetViewController: DynamicBottomSheetViewController {

    // MARK: - Private Properties
    private var stackView: BottomSheetStackView!
    var views: [UIView] = []
}

// MARK: - Layout
extension BaseViewBottomSheetViewController {

    override func configureView() {
        layoutStackView()
        super.configureView()

    }

    private func layoutStackView() {
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.spacing = 32
//        stackView.alignment = .fill
//        stackView.distribution = .fillEqually
        self.stackView = BottomSheetStackView()
        contentView.addSubview(self.stackView)
        var height: CGFloat = 10
        if let safeAreaInsets = AppDelegate.shared.window?.safeAreaInsets.bottom, safeAreaInsets != 0 {
            height = safeAreaInsets
        }
        stackView.stackView.layoutIfNeeded()
        self.height = stackView.stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height + height
        self.stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
//        for view in views {
//            stackView.addArrangedSubview(view)
//        }
//        let view1 = UIView()
//        view1.backgroundColor = .red
//        view1.snp.makeConstraints {
//            $0.height.equalTo(50)
//        }
//        stackView.addArrangedSubview(view1)
//
//        Array(1...5).forEach {
//            let label = UILabel()
//            label.text = "\($0)"
//            stackView.addArrangedSubview(label)
//        }
    }
}

