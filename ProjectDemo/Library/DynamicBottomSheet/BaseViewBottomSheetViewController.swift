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
    private var stackContent: BottomSheetStackView!
    var views: [UIView] = []
    var bottomDataSource: [BottomSheetType] = []
}

// MARK: - Layout
extension BaseViewBottomSheetViewController {

    override func configureView() {
        super.configureView()
        layoutStackView()
    }

    private func layoutStackView() {
        self.stackContent = BottomSheetStackView()
        contentView.addSubview(self.stackContent)
        
        var height: CGFloat = 10
        if let safeAreaInsets = AppDelegate.shared.window?.safeAreaInsets.bottom, safeAreaInsets != 0 {
            height = safeAreaInsets
        }
        
        for type in bottomDataSource {
            height += type.height()
        }
        stackContent.stackView.layoutIfNeeded()
        self.stackContent.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.height.equalTo(height)
        }
        self.stackContent.config(bottomDataSource)
    }
}

