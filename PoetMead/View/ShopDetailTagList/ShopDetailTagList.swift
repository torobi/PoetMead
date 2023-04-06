//
//  ShopDetailTagList.swift
//  PoetMead
//
//  Created by torobi on 2023/04/05.
//

import UIKit

class ShopDetailTagList: UINibView {
    func updateTags(shop: Shop) {
        let areaWidth = self.bounds.size.width
        let tagMargin: CGFloat = 10
        let tagFont = UIFont.systemFont(ofSize: 16)
        let tagHeight = tagFont.lineHeight + TagLabel().tagPadding * 2

        var tagOriginX: CGFloat = 0
        var tagOriginY: CGFloat = 0

        for detail in ShopDetail.allCases {
            let tagText = getTageText(tagName: detail)

            var tagWidth = tagLabelTextWidth(text: tagText, font: tagFont, height: tagHeight)
            if tagWidth > areaWidth {
                tagWidth = areaWidth
            }

            if areaWidth - tagOriginX < tagWidth {
                tagOriginX = 0
                tagOriginY += tagHeight + tagMargin
            }

            let label = TagLabel(frame: CGRect(x: tagOriginX, y: tagOriginY, width: tagWidth, height: tagHeight))
            label.text = tagText
            label.font = tagFont
            label.alpha = isActiveTag(tagName: detail, shop: shop) ? 1 : 0.3
            self.addSubview(label)

            tagOriginX += tagWidth + tagMargin
        }
    }

    private func tagLabelTextWidth(text: String, font: UIFont, height: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: height))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.size.width + TagLabel().tagPadding * 2
    }

    private func isActiveTag(tagName: ShopDetail, shop: Shop) -> Bool {
        switch tagName {
        case .wifi: return shop.wifi == "あり"
        case .course: return shop.course == "あり"
        case .freeDrink: return shop.freeDrink == "あり"
        case .freeFood: return shop.freeFood == "あり"
        case .privateRoom: return shop.privateRoom == "あり"
        case .card: return shop.card == "利用可"
        case .nonSmoking: return shop.nonSmoking == "全席禁煙"
        case .charter: return shop.charter == "貸切可"
        case .parking: return shop.parking == "あり"
        case .barrierFree: return shop.barrierFree == "あり"
        case .pet: return shop.pet == "可"
        }
    }

    private func getTageText(tagName: ShopDetail) -> String {
        switch tagName {
        case .wifi: return "Wi-Fi"
        case .course: return "コース"
        case .freeDrink: return "飲み放題"
        case .freeFood: return "食べ放題"
        case .privateRoom: return "個室あり"
        case .card: return "カード払い"
        case .nonSmoking: return "全席禁煙"
        case .charter: return "貸切可"
        case .parking: return "駐車場"
        case .barrierFree: return "バリアフリー"
        case .pet: return "ペット可"
        }
    }
}
