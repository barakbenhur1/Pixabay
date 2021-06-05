//
//  PhotoPageController.swift
//  Pixabay
//
//  Created by Interactech on 05/06/2021.
//

import UIKit

class PhotoPageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    private var pages = [UIViewController]()
    
    var results: [Result]?
    var startIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        
        navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(back))
        
        guard let results = results else { return }
    
        for result in results {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc: PhotoViewController = storyBoard.instantiateViewController(withIdentifier: "PhotoViewController") as? PhotoViewController else { continue }
            vc.image = result.image
            pages.append(vc)
        }

        setViewControllers([pages[startIndex]], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    @objc private func back() {
        dismiss(animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
       
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == 0 { return nil }

        var prev = (cur - 1) % pages.count
        if prev < 0 {
            prev = pages.count - 1
        }
        return pages[prev]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
         
        let cur = pages.firstIndex(of: viewController)!

        // if you prefer to NOT scroll circularly, simply add here:
        // if cur == (pages.count - 1) { return nil }

        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }

    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
}
