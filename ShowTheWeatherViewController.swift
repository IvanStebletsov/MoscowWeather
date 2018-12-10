//
//  ShowTheWeatherViewController.swift
//  MoscowWeather
//
//  Created by Ivan Stebletsov on 27/11/2018.
//  Copyright © 2018 Ivan Stebletsov. All rights reserved.
//

import UIKit

class ShowTheWeatherViewController: UIViewController {
    
    let weatherJSONurl = "http://api.openweathermap.org/data/2.5/weather?q=Moscow&APPID=c1a8daa2ff99d33cc1136edd230040c7"
    let weatherIconUrl = "http://openweathermap.org/img/w/"
    
    @IBOutlet var cityName: UILabel!
    @IBOutlet var weatherIcon: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var weatherName: UILabel!
    @IBOutlet var weatherNameDescription: UILabel!
    @IBOutlet var pressureMM: UILabel!
    @IBOutlet var humidityPercent: UILabel!
    @IBOutlet var updateData: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData.layer.cornerRadius = 10
        allLabelsLoadingText()
        weatherLoading()
        weatherIconLoading()
        weatherLoading()
        weatherIconLoading()
    }
    
    func weatherLoading() {
        guard let url = URL(string: weatherJSONurl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let date = data else { return }
            
            do {
                
                let loadedData = try JSONDecoder().decode(OpenWeatherMap.self, from: date)
                let temperatureCelsius = "\(Int(loadedData.main["temp"]! - 273.15)) C°"
                let pressure = "\(Int(loadedData.main["pressure"]!)) mm Hg"
                let humidity = "\(Int(loadedData.main["humidity"]!))%"
                
                DispatchQueue.main.async {
                    
                    self.cityName.text = loadedData.name
                    self.temperatureLabel.text = temperatureCelsius
                    self.weatherName.text = loadedData.weather[0].main
                    self.weatherNameDescription.text = loadedData.weather[0].description
                    self.pressureMM.text = pressure
                    self.humidityPercent.text = humidity
                    
                }
                
            } catch {
                print("Error", error)
            }
            } .resume()
    }
    
    
    func weatherIconLoading() {
        guard let url = URL(string: weatherJSONurl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let date = data else { return }
            
            do {
                
                let loadedData = try JSONDecoder().decode(OpenWeatherMap.self, from: date)
                let iconId = loadedData.weather[0].icon
                let currentIconId = "\(self.weatherIconUrl)\(iconId).png"
                
                guard let imageUrl = URL(string: currentIconId) else { return }
                
                URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
                    if let data = data, let image = UIImage(data: data) {
                        
                        DispatchQueue.main.async {
                            
                            self.weatherIcon.image = image
                            
                        }
                    }
                    } .resume()
                
            } catch {
                print("Error", error)
            }
            } .resume()
        
        
    }
    
    func allLabelsLoadingText() {
        cityName.text = "Loading..."
        temperatureLabel.text = "Loading..."
        weatherName.text = "Loading..."
        weatherNameDescription.text = "Loading..."
        pressureMM.text = "Loading..."
        humidityPercent.text = "Loading..."
    }
    
    @IBAction func updateDataTapped(_ sender: UIButton) {
        allLabelsLoadingText()
        weatherLoading()
        weatherIconLoading()
    }
}
