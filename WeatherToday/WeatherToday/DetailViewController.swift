//
//  DetailViewController.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    
    weak var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDesign()
        setContents()
    }
    
    func setDesign(){
        guard let weather = self.weather else {
            return
        }
        if weather.celsius <= 10.0 {
            temperatureLabel.textColor = UIColor.blue
        }
        if weather.rainfallProbability >= 50 {
            rainfallLabel.textColor = UIColor.orange
        }
    }
    
    func setContents(){
        guard let weather = self.weather else {
            return
        }
        navigationItem.title = weather.cityName
        imageView.image = weather.iconImage
        weatherTypeLabel.text = weather.weatherType.toKorean()
        temperatureLabel.text = weather.temperatureText
        rainfallLabel.text = weather.rainfallText
    }
    
}
