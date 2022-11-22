//
//  BottomSheetStackView.swift
//  ProjectDemo
//
//  Created by MacBook Pro on 22/11/2022.
//

import UIKit

class BottomSheetStackView: BaseCustomView {

    @IBOutlet weak var stackView: UIStackView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
    }
     
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
