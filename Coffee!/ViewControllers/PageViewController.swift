//
//  PageViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 01/10/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit
import Foundation

class PageViewController: UIPageViewController {
    
    let pageControl = UIPageControl()
    let vc = ViewController()
    
    private(set) lazy var brewOptionsViewControllers: [UIViewController] = {
        return [newViewController(brewMethod: "drip"),
                newViewController(brewMethod: "frenchPress")
            ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        setPageControl()
        
        if let firstViewController = brewOptionsViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }

    }
    
    // MARK: - Functions
    
    private func setPageControl() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = brewOptionsViewControllers.count
        pageControl.currentPage = 0
        view.addSubview(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        pageControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func newViewController(brewMethod: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(brewMethod)View")
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // MARK: - Protocol functions
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = brewOptionsViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return brewOptionsViewControllers.last
        }
        
        guard brewOptionsViewControllers.count > previousIndex else {
            return nil
        }
        
        return brewOptionsViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = brewOptionsViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard brewOptionsViewControllers.count != nextIndex else {
            return brewOptionsViewControllers.first
        }
        
        guard brewOptionsViewControllers.count > nextIndex else {
            return nil
        }
        
        return brewOptionsViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = brewOptionsViewControllers.firstIndex(of: viewControllers[0]) {
                if pageControl.currentPage != viewControllerIndex {
                    NotificationCenter.default.post(name: Notification.Name(".pageTransitionOccured"), object: nil)
                }
                
                pageControl.currentPage = viewControllerIndex
                UserDefaults.standard.set(pageControl.currentPage, forKey: Constants.indexKey)
            }
        }
    }
}
