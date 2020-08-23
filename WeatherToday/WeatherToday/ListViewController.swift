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
    
    var nationType: NationType?
    var weathers: [Weather] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addScreenSettings()
        loadData()
    }
    
    func addScreenSettings(){
        // icon image 아래 separator 가 안생겨서 storyboard tableView 설정에서 custom 으로 넣었음
        // tableView.separatorInset = UIEdgeInsets.zero
        navigationItem.backBarButtonItem?.title = "세계 날씨"
        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        navigationItem.title = nationType?.toKorean()
    }
    
    func loadData(){
        let jsonDecoder = JSONDecoder()
        guard let nationType = self.nationType,
            let dataAsset = NSDataAsset(name: nationType.rawValue) else {
            return
        }
        do{
            weathers = try jsonDecoder.decode([Weather].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
        self.tableView.reloadData()
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
