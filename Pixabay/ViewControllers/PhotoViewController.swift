//
//  PhotoViewController.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    
    var image: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(image: image)
    }
    
    private func setImage(image: String) {
        self.photoView.kf.setImage(with: URL(string: image), placeholder: nil, options: nil) { (image) in
        }
    }
}
