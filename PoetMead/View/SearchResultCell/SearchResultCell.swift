//
//  SearchResultCell.swift
//  PoetMead
//
//  Created by torobi on 2023/04/03.
//

import UIKit

class SearchResultCell: UITableViewCell {
    @IBOutlet var name: UILabel!

    @IBOutlet var thumbnail: UIImageView!

    @IBOutlet var access: UILabel!

    @IBOutlet var catchMemo: UILabel!

    func setContent(shop: Shop) {
        name.text = shop.name
        setThumbnail(shop.photo.largeImageUrl)
        access.text = shop.mobileAccess
        catchMemo.text = shop.`catch`
    }

    private func setThumbnail(_ imageUrl: URL?) {
        fetchImage(imageUrl: imageUrl) { image in
            DispatchQueue.main.async {
                self.thumbnail.image = image
            }
        }
    }

    static let className = "SearchResultCell"
    static let cellReuseIdentifier = "searchResultCell"
}
