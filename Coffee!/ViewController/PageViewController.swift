//
//  PageViewController.swift
//  Coffee!
//
//  Created by Hana Kaspříková on 01/10/2018.
//  Copyright © 2018 Hana Kaspříková. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = brewOptionsViewControllers.index(of: viewController) else {
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
        
        guard let viewControllerIndex = brewOptionsViewControllers.index(of: viewController) else {
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
            if let viewControllerIndex = brewOptionsViewControllers.index(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
                Constants.pendingIndex = pageControl.currentPage
            }
        }
    }
    
    let pageControl = UIPageControl()
    
    private(set) lazy var brewOptionsViewControllers: [UIViewController] = {
        return [self.newViewController(brewMethod: "drip"),
                self.newViewController(brewMethod: "frenchPress"),
                self.newViewController(brewMethod: "auto")
            ]
    }()
    
    private func newViewController(brewMethod: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(brewMethod)View")
    }
    
    private func setPageControl() {
        pageControl.frame = CGRect()
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = brewOptionsViewControllers.count
        pageControl.currentPage = 0
        view.addSubview(self.pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

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

}
