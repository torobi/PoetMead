//
//  ViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/03/27.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GourmetSearchAPI().searchRestaurant(
            latitude: 35.68144697760588,
            longitude: 139.76595615737682,
            range: 5,
            completionHandler: { _ in })
    }
}
