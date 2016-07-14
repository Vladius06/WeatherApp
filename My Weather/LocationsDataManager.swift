//
//  LocationsDataManager.swift
//  My Weather
//
//  Created by Vladyslav Poznyak on 7/14/16.
//  Copyright © 2016 Vladyslav Poznyak. All rights reserved.
//

import Foundation

final class LocationsDataManager
{
    static let sharedManager = LocationsDataManager()
    
    private let filePath = NSSearchPathForDirectoriesInDomains(
        NSSearchPathDirectory.DocumentDirectory,
        NSSearchPathDomainMask.UserDomainMask,
        true
        ).first
    
    private lazy var _queries: [String] = {
        var userQueries = [String]()
        if let filePath = self.filePath {
            if let data = NSData(contentsOfFile: filePath) {
                if let queries = try? NSJSONSerialization.JSONObjectWithData(data, options: []) where queries is [String] {
                    userQueries = queries as! [String]
                }
            }
        }
        return userQueries
    }()
    
    private init()
    {
        
    }
    
    var userQueries: [String] {
        get {
            return _queries
        }
        
        set {
            _queries = newValue
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(_queries, options: [])
                if let filePath = filePath {
                    if !data.writeToFile(filePath, atomically: true) {
                        print("Didn't save added location: \(newValue)")
                    }
                }
            } catch {
                print(error)
            }
        }
    }
}
