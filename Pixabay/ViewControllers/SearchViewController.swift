//
//  ViewController.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private lazy var presenter: Presenter = SearchPresenter()
    
    private var searchField: UITextField!
    
    private var collectionView: UICollectionView!
    
    private var results: [Result]?
    
    private var isReloadMore = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        presenter.attachView(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchField.becomeFirstResponder()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        let searchView = setupSearchField()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchView)
        
        let searchButton = setupSearchButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 30, right: 10)
        layout.itemSize = CGSize(width: 120, height: 120)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: self.navigationController?.navigationBar.frame.height ?? 100, width: view.frame.width, height: view.frame.height - 100), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "SearchResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "\(SearchResultCollectionViewCell.self)")
        collectionView.backgroundColor = UIColor.white
        
        (collectionView as? UIScrollView)?.delegate = self
        
        view.addSubview(collectionView)
    }
    
    private func setupSearchButton() -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
        
        return button
    }
    
    private func setupSearchField() -> UIView {
        let wrapper = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        self.searchField = searchField
        searchField.tintColor = .black
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
        guard let text = searchField.text else { return }
        presenter.search(text: text, new: true)
    }
}

extension SearchViewController: View {
    func showResults(results: [Result], new: Bool) {
        if new {
            self.results = results
        }
        else {
            self.results?.append(contentsOf: results)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let results = results, let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SearchResultCollectionViewCell.self)", for: indexPath) as? SearchResultCollectionViewCell else { return SearchResultCollectionViewCell() }
        let index = indexPath.row
        myCell.backgroundColor = .clear
        let title = results[index].text
        let photo = results[index].image
        myCell.set(image: photo, text: title)
        
        myCell.layer.borderColor = UIColor.black.cgColor
        myCell.layer.borderWidth = 2
        myCell.layer.cornerRadius = 10
        
        return myCell
    }
}

extension SearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoViewController = PhotoPageController()
        photoViewController.results = results
        photoViewController.startIndex = indexPath.row
       
        let navigationController = UINavigationController(rootViewController: photoViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}

extension SearchViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maximumOffset - contentOffset <= -30) {
            guard isReloadMore, results?.isEmpty == false, let text = searchField.text else { return }
//            collectionView.isUserInteractionEnabled = false
            isReloadMore = false
            presenter.search(text: text, new: false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        collectionView.isUserInteractionEnabled = true
        isReloadMore = true
    }
}
