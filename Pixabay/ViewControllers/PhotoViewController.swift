//
//  PhotoViewController.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit
import Kingfisher

class PhotoViewController: UIViewController {
    private lazy var photoView: UIImageView = UIImageView(frame: view.frame)
    var image: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        photoView.contentMode = .scaleAspectFit
        setImage(image: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(photoView)
    }
    
    private func setImage(image: String) {
        let loading = UIActivityIndicatorView()
        loading.frame = view.frame
        view.addSubview(loading)
        loading.hidesWhenStopped = true
        loading.startAnimating()
        self.photoView.kf.setImage(with: URL(string: image), placeholder: nil, options: nil) { (image) in
            loading.stopAnimating()
        }
    }
}
