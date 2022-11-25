//
//  BottomSheetStackView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 22/11/2022.
//

import UIKit
import SnapKit

enum BottomSheetType {
    case draggable
    case label(String)
    case button(title: String, isPrimary: Bool)
    case content(title: String, content: String)
    
    func height() -> CGFloat {
        switch self {
        case .draggable:
            return 14
        case .label:
            return 65
        case .button:
            return 44
        case .content:
            return 100
        }
    }
}

class BottomSheetStackView: BaseCustomView {

    @IBOutlet weak var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func config(_ dataSource: [BottomSheetType]) {
        let newDataSource = [.draggable] + dataSource
        for type in newDataSource {
            switch type {
            case .label(let title):
                let view = BottomSheetLabelView()
                view.lbTitle.text = title
                self.stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.height.equalTo(type.height())
                }
            case .button(let title, let isPrimary):
                let view = BottomSheetButtonView()
                view.title = title
                view.isPrimary = isPrimary
                self.stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.height.equalTo(type.height())
                }
            case .content(let title, let content):
                let view = BottomSheetContentView()
                view.title = title
                view.content = content
                self.stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.height.equalTo(type.height())
                }
            case .draggable:
                let view = BottomSheetDraggableView()
                self.stackView.addArrangedSubview(view)
                view.snp.makeConstraints {
                    $0.height.equalTo(type.height())
                }
            }
        }
        
        //Last View for bottom
        self.stackView.addArrangedSubview(UIView())
    }
}
