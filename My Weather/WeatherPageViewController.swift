//
//  WeatherPageViewController.swift
//  My Weather
//
//  Created by Vladyslav Poznyak on 7/12/16.
//  Copyright © 2016 Vladyslav Poznyak. All rights reserved.
//

import UIKit

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        Webservice.loadResource(weatherResource) { result in
            if let weather = Weather(json: result) {
                self.weathers = [weather]
            }
        }
    }
    
    private let weatherResource = WebResource<AnyObject>(weatherAPISourceString: "conditions/q/zmw:00000.4.33393.json") { data in
        let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
        return json
    }
    
    private var weathers: [Weather] = [] {
        didSet {
            setViewControllers(
                weatherViewControllers,
                direction: .Forward,
                animated: true,
                completion: nil
            )
        }
    }
    
    lazy var weatherViewControllers: [UIViewController] = {
        var controllers = [UIViewController]()
        for weather in self.weathers {
            if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(MainStoryboard.ViewControllers.WeatherViewControllerId) as? WeatherViewController {
                controller.weather = weather
                controllers.append(controller)
            }
        }
        return controllers
    }()
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = weatherViewControllers.indexOf(viewController) where
            viewControllerIndex + 1 < weatherViewControllers.count {
            return weatherViewControllers[viewControllerIndex + 1]
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = weatherViewControllers.indexOf(viewController) where
            viewControllerIndex - 1 >= 0 {
            return weatherViewControllers[viewControllerIndex - 1]
        }
        return nil
    }
    
}
