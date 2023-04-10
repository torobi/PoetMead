//
//  SearchNavigationViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/04/08.
//

import Foundation
import UIKit

// 検索条件画面のみステータスバーの文字色を黒にするために実装
class SearchNavigationViewController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
}
