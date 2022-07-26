//
//  CollectionCell.swift
//  RickAndMarty
//
//  Created by İSMAİL AÇIKYÜREK on 19.07.2022.
//

import UIKit
import Kingfisher

class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblNAme: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    func configure(content: Result) {
        lblNAme.text = content.name
        guard let urlStr = content.image else { return }
        imageView.kf.setImage(with:URL(string: urlStr))
    }
}
