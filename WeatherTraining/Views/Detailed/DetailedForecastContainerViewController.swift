//
//  DetailedForecastContainerViewController.swift
//  WeatherTraining
//
//  Created by Bénédicte Lagouge on 22/07/2021.
//

import UIKit

class DetailedForecastContainerViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    
    private var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    private var pages: [UIViewController] = []
    
    var initialPosition: Int = 0
    
    private var cities: [City] = []
    
    override func loadView() {
        super.loadView()
        
        cities = CitiesManager.shared.getCities()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        addChild(pageViewController)
        view.insertSubview(pageViewController.view, belowSubview: backButton)
        
        loadPages()
        
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.backgroundColor = UIColor.clear
        pageViewController.view.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        print("click on go back")
        dismiss(animated: true, completion: nil)
    }
    
    func loadPages() {
        let storyboard = UIStoryboard.init(name: "Detailed", bundle: nil)
        
        for i in 0...cities.count-1 {
            let city = cities[i]
            let page = storyboard.instantiateViewController(withIdentifier: "detailed") as! DetailedForecastViewController
            
            page.city = city
            
            pages.append(page)
        }
        
        pageViewController.setViewControllers([pages[initialPosition]], direction: .forward, animated: true, completion: nil)
    }
}

extension DetailedForecastContainerViewController: UIPageViewControllerDataSource {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cities.count
    }
}
//backgroundImageView.image = UIImage(named: city!.weatherPreviews[0].getAssociatedBigImageName())
extension DetailedForecastContainerViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard pages.count > previousIndex else {
            return nil
        }

        let city = (viewController as! DetailedForecastViewController).city!
        
        backgroundImageView.image = UIImage(named: city.weatherPreviews[0].getAssociatedBigImageName())
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        let city = (viewController as! DetailedForecastViewController).city!
        
        backgroundImageView.image = UIImage(named: city.weatherPreviews[0].getAssociatedBigImageName())
        
        return pages[nextIndex]
    }
}
