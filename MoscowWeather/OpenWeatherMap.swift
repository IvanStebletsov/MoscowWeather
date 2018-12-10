//
//  OpenWeatherMapJSON.swift
//  MoscowWeather
//
//  Created by Ivan Stebletsov on 27/11/2018.
//  Copyright © 2018 Ivan Stebletsov. All rights reserved.
//

import Foundation

struct OpenWeatherMap: Decodable {
    
    let weather: [Weather]
    let name: String
    let main: [String: Double]

}

struct Weather: Decodable {
    
    let main: String
    let icon: String
    let description: String
    
}
