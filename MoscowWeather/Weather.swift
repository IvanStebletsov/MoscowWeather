//
//  Weather.swift
//  MoscowWeather
//
//  Created by Ivan Stebletsov on 27/11/2018.
//  Copyright © 2018 Ivan Stebletsov. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    
    let main: String
    let icon: String
    let description: String
    
}
