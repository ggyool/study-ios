//
//  ListViewController.swift
//  WeatherToday
//
//  Created by ggyool on 2020/08/23.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nation: Nation?
    var weathers: [Weather] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavagationSettings()
        loadData()
    }
    
    func addNavagationSettings(){
        // icon image 아래 separator 가 안생겨서 storyboard tableView 설정에서 custom 으로 넣었음
        // tableView.separatorInset = UIEdgeInsets.zero
        navigationItem.backBarButtonItem?.title = "세계 날씨"
        navigationItem.title = nation?.koreanName
    }
    
    func loadData(){
        let jsonDecoder = JSONDecoder()
        guard let nation = self.nation,
            let dataAsset = NSDataAsset(name: nation.name) else {
            return
        }
        do{
            weathers = try jsonDecoder.decode([Weather].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            as? CustomTableViewCell_ListView else {
            preconditionFailure("cell 불러오기 실패")
        }
        let weather: Weather = weathers[indexPath.row]
        
        // 섭씨 10도 이하면 파랑색
        if weather.celsius <= 10.0 {
            cell.temperatureLabel.textColor = UIColor.blue
        } else {
            cell.temperatureLabel.textColor = UIColor.black
        }
        
        // 강수확률 50% 이상이면 주황색
        if weather.rainfallProbability >= 50 {
            cell.rainfallLabel.textColor = UIColor.orange
        } else {
            cell.rainfallLabel.textColor = UIColor.black
        }
        cell.iconImageView.image = weather.iconImage
        cell.cityNameLabel.text = weather.cityName
        cell.temperatureLabel.text = weather.temperatureText
        cell.rainfallLabel.text = weather.rainfallText
        return cell
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? DetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        nextViewController.weather = weathers[indexPath.row]
    }
    
    
    

}
