//
//  WeatherViewController.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 12/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var txtFieldViewHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var textField : UITextField!
    var weatherList : [WeatherData] = []
    
    lazy var CityList: [CityData] = {
        if let path = Bundle.main.path(forResource: "city.list", ofType: "json") {
            do{
                      let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                      let decoder = JSONDecoder()
                let athleteList = try decoder.decode([CityData].self, from: jsonData)
                //print(athleteList)
                return athleteList
                } catch {
                    return []
            }
        }
        return []
        
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        //init view top city
        self.fetchWeatherData(cityIds: ["524901","703448","2643743"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
  
    
    @IBAction func collectWeatherAction(_ sender: UIButton) {
        var cityIDArr : [String] = []
        guard let citysName = self.textField.text else {
            return
        }
        let cityNameArr = citysName.components(separatedBy: ",")
        guard cityNameArr.count > 2 else {
            self.showNormalAlert(title: "Weather App", msg: "Minimum 3 city name")
            return
        }
        guard cityNameArr.count < 7 else {
            self.showNormalAlert(title: "Weather App", msg: "Maximum 7 city name")
            return
        }
        for city in cityNameArr{
            let filteredItems = CityList.filter { $0.name.lowercased() == "\(city.lowercased())" }
            if filteredItems.count > 0{
                cityIDArr.append("\(filteredItems[0].id)")
            }
        }
        guard cityIDArr.count > 2 else {
            self.showNormalAlert(title: "Weather App", msg: "City name not match")
            return
        }
        
        self.fetchWeatherData(cityIds: cityIDArr)
    }
    
     @IBAction func getCurrentLocation(_ sender: UIButton) {
        
     }
    
    
}
extension WeatherViewController : UITableViewDataSource {
    func fetchWeatherData(cityIds : [String]) {
        var cityIdStr = ""
        for id in cityIds {
            cityIdStr = cityIdStr + "\(id),"
        }
        self.showSpinner(onView: self.view)
        WeatherDataManager.shared.weatherDataAt(citys : cityIdStr, completion: {
            response, error in
            if let error = error {
                dump(error)
            } else if response != nil {
                self.weatherList = (response?.list)!
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.title = "Weather"
                    self.tableView.reloadData()
                }
            }
        })
    }
        
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell

        let weatherData = self.weatherList[indexPath.row]
        cell.setCellDataWeather(weatherDataObj: weatherData)
        return cell
    }
}



