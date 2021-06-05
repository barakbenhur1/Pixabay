//
//  SearchResultCollectionViewCell.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    var text: UILabel!
    
    func set(image: String, text: String) {
    
        self.layer.borderColor = UIColor.clear.cgColor
        
        if self.image != nil {
            self.image.alpha = 0
            self.image.removeFromSuperview()
        }
        
        if self.text != nil {
            self.text.alpha = 0
            self.text.removeFromSuperview()
        }
        
        let loading = UIActivityIndicatorView()
        loading.frame = frame
        
        addSubview(loading)
        
        loading.center = center
        
        loading.hidesWhenStopped = true
        
        loading.startAnimating()
        
        let height = frame.height - 5
        self.image = UIImageView(frame: CGRect(x: 5, y: 5, width: self.frame.width - 10, height: height * 0.55))
        self.image.kf.setImage(with: URL(string: image), placeholder: nil, options: nil) { (image) in
            self.addSubview(self.image)
            
            self.text = UILabel(frame: CGRect(x: 5, y: self.image.frame.height, width: self.frame.width - 10, height: height * 0.45))
            self.text.font = UIFont.systemFont(ofSize: 12)
            self.text.numberOfLines = 0
            self.text.textAlignment = .center
            self.text.text = text
        
            self.addSubview(self.text)
            
            loading.stopAnimating()
            
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.black.cgColor
            
            self.layer.cornerRadius = 10
            self.image.layer.cornerRadius = 10
            self.text.layer.cornerRadius = 10
            
            self.text.alpha = 1
            self.image.alpha = 1
        }
    }
}
