//
//  BottomSheetDraggableView.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 25/11/2022.
//

import UIKit

class BottomSheetDraggableView: BaseCustomView {
    
    @IBOutlet weak var a: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        a.backgroundColor = .red
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
