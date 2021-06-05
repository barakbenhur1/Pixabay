//
//  SearchResultCollectionViewCell.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var text: UILabel!
    @IBOutlet var loading: UIActivityIndicatorView!
    
    func set(image: String, text: String) {
        loading.startAnimating()
    
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.text.text = text
        
        self.image.kf.setImage(with: URL(string: image), placeholder: nil, options: nil) { (image) in
            self.loading.stopAnimating()
        }
    }
}
