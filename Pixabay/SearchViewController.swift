//
//  ViewController.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    private let apiKey = "21949381-e9a7117a196e6fac3808fa43f"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
//        self.navigationController?.navigationBar.barTintColor = .clear
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .automatic
        let searchView = setupSearchField()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchView)
        
        let searchButton = setupSearchButton()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func setupSearchButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        return button
    }
    
    private func setupSearchField() -> UIView {
        let wrapper = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        searchField.placeholder = "Search"
        wrapper.layer.borderWidth = 0.8
        wrapper.layer.borderColor  = UIColor.black.cgColor
        wrapper.layer.cornerRadius = 10
        
        wrapper.addSubview(searchField)
        searchField.center = wrapper.center
        
        wrapper.backgroundColor = .white
        
        return wrapper
    }
    
    @objc private func searchTapped() {
       print("Tap")
    }
}

