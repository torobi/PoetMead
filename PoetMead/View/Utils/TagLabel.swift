//
//  TagLabel.swift
//  PoetMead
//
//  Created by torobi on 2023/04/05.
//

import UIKit

/// 枠線で囲われたLabel
class TagLabel: UILabel {
    let tagPadding: CGFloat = 5

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 5
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        textColor = UIColor.black
        clipsToBounds = true
        numberOfLines = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets(top: tagPadding, left: tagPadding, bottom: tagPadding, right: tagPadding)
        return super.drawText(in: rect.inset(by: insets))
    }
}
