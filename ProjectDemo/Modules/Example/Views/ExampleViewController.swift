//
//  ExampleViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ExampleViewController: UIViewController {

    // MARK: - Properties
	var presenter: ExamplePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a = TestObjc.init()
        
        a.changeValue()
        a.changeValue("abc")
        a.counter = 1
        
        // a.value is unwrapped
        print("\(a.value.isEmpty)")
        print("\(a.counter)")
    }
}

// MARK: - ExampleViewInterface
extension ExampleViewController: ExampleViewInterface {
}
