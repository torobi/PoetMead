//
//  SearchNavigationViewController.swift
//  PoetMead
//
//  Created by torobi on 2023/04/08.
//

import Foundation
import UIKit

class SearchNavigationViewController: UINavigationController {
    override public var childForStatusBarStyle: UIViewController? {
        return self.visibleViewController
    }
}
