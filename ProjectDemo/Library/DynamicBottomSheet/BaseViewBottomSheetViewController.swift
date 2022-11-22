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
    private var stackView: UIStackView!
    var views: [UIView] = []
}

// MARK: - Layout
extension BaseViewBottomSheetViewController {

    override func configureView() {
        super.configureView()
        layoutStackView()
    }

    private func layoutStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        self.stackView = stackView
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        for view in views {
            stackView.addArrangedSubview(view)
        }
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
