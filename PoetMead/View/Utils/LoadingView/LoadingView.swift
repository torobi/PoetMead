//
//  LoadingView.swift
//  PoetMead
//
//  Created by torobi on 2023/04/02.
//

import UIKit

/// ロード画面
class LoadingView: UINibView {
    @IBOutlet var discriptionLabel: UILabel!

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func didInit() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        frame = UIScreen.main.bounds
    }

    func setDescription(discription: String) {
        discriptionLabel.text = discription
    }
}
