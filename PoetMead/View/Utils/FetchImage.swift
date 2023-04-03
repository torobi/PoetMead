//
//  FetchImage.swift
//  PoetMead
//
//  Created by torobi on 2023/04/03.
//

import Foundation
import UIKit

func fetchImage(imageUrl: URL?, fetchCompleteHandler: @escaping (_ image: UIImage) -> Void) {
    guard let imgUrl = imageUrl else {
        fetchCompleteHandler(getNoImage())
        return
    }
    URLSession.shared.dataTask(with: imgUrl) { data, _, err in
        if let err {
            fetchCompleteHandler(getNoImage())
            print(err)
            return
        }
        guard let data else {
            fetchCompleteHandler(getNoImage())
            return
        }

        let img = UIImage(data: data) ?? getNoImage()
        fetchCompleteHandler(img)
    }.resume()
}

private func getNoImage() -> UIImage {
    return UIImage(named: "noImage")!
}
