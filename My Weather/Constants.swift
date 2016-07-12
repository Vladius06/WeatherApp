//
//  Constants.swift
//  My Weather
//
//  Created by Vladyslav Poznyak on 7/12/16.
//  Copyright © 2016 Vladyslav Poznyak. All rights reserved.
//

import Foundation

struct MainStoryboard
{
    struct ViewControllers {
        static let WeatherViewControllerId = "WeatherViewControllerId"
    }
}

struct WeatherConditions
{
    static let locationKeyPath = "current_observation.observation_location.city"
    static let temperatureCelsiusKeyPath = "current_observation.temp_c"
    static let weatherKeyPath = "current_observation.weather"
}