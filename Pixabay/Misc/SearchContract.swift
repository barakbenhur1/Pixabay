//
//  SearchContract.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit

typealias Result = (image: String, text: String)

protocol View {
    func showResults(results: [Result], new: Bool)
}

protocol Presenter {
    func attachView(view: View)
    func search(text: String, new: Bool)
}
