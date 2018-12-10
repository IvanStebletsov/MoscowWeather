//
//  ViewController.swift
//  MoscowWeather
//
//  Created by Ivan Stebletsov on 28/11/2018.
//  Copyright © 2018 Ivan Stebletsov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var showBotton: UIButton!
    @IBOutlet var weathersIcons: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showBotton.layer.cornerRadius = 10
        animate(weathersIcons)
    }
    
    
    func animate(_ image: UIImageView) {  // не был овремени самому делать, нашел готовы вариант на stackoverflow
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveLinear],
                       animations: {image.center.x -= 10},
                       completion: {_ in self.animate(image)})
    }
}
