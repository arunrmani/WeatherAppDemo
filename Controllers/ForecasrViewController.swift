//
//  ForecasrViewController.swift
//  WeatherAppDemo
//
//  Created by Safe City Mac 001 on 13/05/2020.
//  Copyright © 2020 Arun R Mani. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var textField : UITextField!
    var weatherList : [WeatherData] = []
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        
        return manager
    }()
    private var currentLocation: CLLocation? {
           didSet {
              
           }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestLocation()
        // Do any additional setup after loading the view.
    }
    private func requestLocation() {
             locationManager.delegate = self
             if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                 locationManager.requestLocation()
             } else {
                 locationManager.requestWhenInUseAuthorization()
             }
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


extension ForecastViewController : UITableViewDataSource {
    func fetchWeatherForecastData(latlonStr : String) {
        self.showSpinner(onView: self.view)
        WeatherDataManager.shared.weatherForecastDataAt(latlonStr : latlonStr, completion: {
               response, error in
               if let error = error {
                   dump(error)
               } else if response != nil {
                   self.weatherList = (response?.list)!
                   DispatchQueue.main.async {
                    self.removeSpinner()
                    self.title = response?.cityName ?? "Forecast"
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
        cell.setCellDataForcast(weatherDataObj: weatherData)
        return cell
    }
}

extension ForecastViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            self.fetchWeatherForecastData(latlonStr: "lat=\(currentLocation?.coordinate.latitude ?? 0.0)&lon=\(currentLocation?.coordinate.longitude ?? 0.0)")
            manager.delegate = nil
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

