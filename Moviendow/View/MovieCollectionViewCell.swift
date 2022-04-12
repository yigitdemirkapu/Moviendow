//
//  MovieCollectionViewCell.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import UIKit
import SDWebImage

struct MovieCollectionViewCellData {
    var year: String?
    var type: String?
    var imageUrl: URL?
}

final class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 10
    }

    func set(with data: MovieCollectionViewCellData) {
        titleLabel.text = "\(data.type ?? "") - \(data.year ?? "")"
        imageView.sd_setImage(with: data.imageUrl, placeholderImage: UIImage(systemName: "film"))
    }
}
