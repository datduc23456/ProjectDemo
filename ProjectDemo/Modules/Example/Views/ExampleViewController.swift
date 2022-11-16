//
//  ExampleViewController.swift
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 20/10/2022.
//  Copyright © 2022 dat.nguyen. All rights reserved.
//

import UIKit

final class ExampleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
	var presenter: ExamplePresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BaseWithCollectionTableViewCell.self, forCellReuseIdentifier: BaseWithCollectionTableViewCell.className)
    }
}

// MARK: - ExampleViewInterface
extension ExampleViewController: ExampleViewInterface {
}

extension ExampleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseWithCollectionTableViewCell.className, for: indexPath) as! BaseWithCollectionTableViewCell
        
        let a = FlowLayoutAttribute.init(itemSize: CGSize(), estimatedItemSize: CGSize(), minimumInteritemSpacing: 4.0, minimumLineSpacing: 4.0, footerReferenceSize: CGSize(), headerReferenceSize: CGSize())
        return cell
    }
}
