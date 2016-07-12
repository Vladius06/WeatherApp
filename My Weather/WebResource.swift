//
//  WebResource.swift
//  My Weather
//
//  Created by Vladyslav Poznyak on 7/12/16.
//  Copyright © 2016 Vladyslav Poznyak. All rights reserved.
//

import Foundation

let sourceURL = "http://api.wunderground.com/api/"
let apiKey = "b139ef851714f152"

struct WebResource <ResultType>
{
    let url: NSURL
    let parse: NSData -> ResultType?
    
    init(weatherAPISourceString source: String, parseFuction parse: (NSData) -> ResultType?)
    {
        var url = NSURL(string: sourceURL + apiKey) ?? NSURL()
        url = url.URLByAppendingPathComponent(source)
        self.url = url
        self.parse = parse
    }
}

final class Webservice
{
    class func loadResource<ResultType>(resource: WebResource <ResultType>, withCompletionHandler handler: (ResultType?) -> ())
    {
        NSURLSession.sharedSession().dataTaskWithURL(resource.url) { data, responce, error in
            guard error == nil else {
                print("Error occured trying to load resource:\n\(error!)")
                return
            }
            
            guard let httpResponce = responce as? NSHTTPURLResponse where httpResponce.statusCode == 200 else {
                var description: String?
                if let data = data {
                    description = String(data: data, encoding: NSUTF8StringEncoding)!
                }
                print("Received responce\n\(responce)\ndescription\n\(description)")
                return
            }
            
            let result = data.flatMap(resource.parse)
            dispatch_async(dispatch_get_main_queue()) {
                handler(result)
            }
        }.resume()
    }
}
