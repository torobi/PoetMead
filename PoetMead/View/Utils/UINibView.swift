//
//  UINibView.swift
//  PoetMead
//
//  Created by torobi on 2023/03/30.
//

import UIKit

class UINibView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibInit()
    }

    func didInit() {}

    private func nibInit() {
        let nib = UINib(nibName: className, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        self.addSubview(view)

        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                              options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: bindings))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                              options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                              metrics: nil,
                                                              views: bindings))

        didInit()
    }

    var className: String {
        return String(describing: type(of: self))
    }
}
