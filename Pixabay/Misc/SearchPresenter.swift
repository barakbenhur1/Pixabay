//
//  SearchPresenter.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit

class SearchPresenter: Presenter {
    private let apiKey = "21949381-e9a7117a196e6fac3808fa43f"
    
    private var page = 1
    
    private var view: View!
    
    func attachView(view: View) {
        self.view = view
    }
    
    func search(text: String, new: Bool) {
        
        if new {
            page = 1
        }
        
        let searchString = "https://pixabay.com/api/?key=\(apiKey)&q=\(text)&image_type=photo&page=\(page)"
        
        guard let url = URL(string: searchString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let strongSelf = self, let data = data, let convertedJsonIntoDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else { return }
            
            guard let resultsDictArray = (convertedJsonIntoDict["hits"] as? [[String : Any]]) else { return }
           
            var results = [Result]()
          
            for hit in resultsDictArray {
                guard let image =  hit["largeImageURL"] as? String, let tags = hit["tags"] as? String else { continue }
                let result: Result = (image: image, text: tags)
                results.append(result)
            }
            self?.page += 1
            strongSelf.view.showResults(results: results, new: new)
        }
        task.resume()
    }
}
