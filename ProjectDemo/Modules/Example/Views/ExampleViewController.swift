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
}

// MARK: - ExampleViewInterface
extension ExampleViewController: ExampleViewInterface {
}
