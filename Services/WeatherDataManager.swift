//
//  WeatherDataManager.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 12/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class WeatherDataManager {
    internal let baseURL: String
    internal let key: String

    internal init(baseURL: String,key : String) {
        self.baseURL = baseURL
        self.key = key
    }

    static let shared = WeatherDataManager(baseURL: API.baseURL, key: API.key)
    
    typealias CompletionHandler = (WeatherDataList?, DataManagerError?) -> Void
    
    func weatherDataAt(citys : String, completion: @escaping CompletionHandler) {

        let urlStr = self.baseURL + "group?id=\(citys)&units=Metric&appid=\(self.key)"
        
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
        }).resume()
    }
    
    func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    print(json as Any)
                    
                    let weatherDataList = WeatherDataList(dic: json!)
                    print(weatherDataList)
                    completion(weatherDataList, nil)

                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
    
    
    func weatherForecastDataAt(latlonStr : String, completion: @escaping CompletionHandler) {
        let urlStr = self.baseURL + "forecast?\(latlonStr)&appid=\(self.key)"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) in
            self.didFinishGettingWeatherForecastData(data: data, response: response, error: error, completion: completion)
        }).resume()
    }
    
    func didFinishGettingWeatherForecastData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    print(json as Any)
                    
                    let weatherDataList = WeatherDataList(dic: json!)
                    print(weatherDataList)
                    completion(weatherDataList, nil)

                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknown)
        }
    }
}

