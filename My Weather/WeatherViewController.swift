//
//  WeatherViewController.swift
//  My Weather
//
//  Created by Vladyslav Poznyak on 7/12/16.
//  Copyright © 2016 Vladyslav Poznyak. All rights reserved.
//

import UIKit

struct Weather
{
    enum WeatherType: String {
        case Sunny, Cloudy, Rainy, Stormy, Clear, Unsupported
    }
    
    let location: String
    let weatherType: WeatherType
    let temperature: String
    
    init?(json: AnyObject?)
    {
        guard let jsonDict = json as? NSDictionary else { return nil }
        
        guard let location = jsonDict.valueForKeyPath(WeatherConditions.locationKeyPath) as? String,
            let temperatue = jsonDict.valueForKeyPath(WeatherConditions.temperatureCelsiusKeyPath) as? NSNumber,
            let weather = jsonDict.valueForKeyPath(WeatherConditions.weatherKeyPath) as? String else { return nil }
        self.location = location
        self.temperature = temperatue.stringValue + " °"
        self.weatherType = WeatherType(rawValue: weather.capitalizedString) ?? .Unsupported
    }
}

class WeatherViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var weatherLabel: UILabel!
    @IBOutlet private weak var temperatureLabel: UILabel!

    var weather: Weather? {
        didSet {
            setupUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI()
    {
        if let weather = weather {
            imageView?.image = UIImage(named: weather.weatherType.rawValue)
            cityLabel?.text = weather.location
            weatherLabel?.text = weather.weatherType.rawValue
            temperatureLabel?.text = weather.temperature
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
