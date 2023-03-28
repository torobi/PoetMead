//
//  RangeSlider.swift
//  PoetMead
//
//  Created by torobi on 2023/03/28.
//

import UIKit

class RangeSlider: UINibView {
    private let rangeIndex = 0

    @IBOutlet var label: UILabel!
    @IBOutlet var cells: [UIButton]!

    var range: Int {
        searchRange[rangeIndex]
    }

    override func didInit() {
        setupCells()
        updateCell(value: rangeIndex)
        updateLabel(rangeIndex: rangeIndex)
    }

    private func setupCells() {
        for i in 0..<cells.count {
            cells[i].layer.cornerRadius = 2
            deactivateCell(index: i)
            cells[i].addAction(.init {_ in
                self.updateCell(value: i)
                self.updateLabel(rangeIndex: i)
            }, for: .touchDown)
        }
    }

    private func updateCell(value: Int) {
        for i in 0..<cells.count {
            if i <= value {
                activateCell(index: i)
            } else {
                deactivateCell(index: i)
            }
        }
    }

    private func updateLabel(rangeIndex: Int) {
        label.text = String(searchRange[rangeIndex]) + "m"
    }

    private func activateCell(index: Int) {
        cells[index].backgroundColor = .gray
    }

    private func deactivateCell(index: Int) {
        cells[index].backgroundColor = .lightGray
    }
}
