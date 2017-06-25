//
//  APIManager.swift
//  Weather Info
//
//  Created by surendra kumar on 6/24/17.
//  Copyright © 2017 weza. All rights reserved.
//

import Foundation


protocol APIManagerDelegate {
    func didWeatherAvailable(weatherItems : [WeatherItem])
}

class APIManager{
    public static let  sharedInstance = APIManager()
    var delegate : APIManagerDelegate?
    
    func loadWeatherData(url : String){
        URLSession.shared.dataTask(with: URL(string : url)!) { (data, response, error) in
            print("LOAD")
            if (error != nil){
                print(error?.localizedDescription ?? "NA")
            }else{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? JSONDictionary{
                        if let cityItem = json["city"] as? JSONDictionary{
                            let _ = City(data: cityItem)
                            }
                        if let list = json["list"] as? JSONArray{
                            var weatherItems = [WeatherItem]()
                            for item in list.enumerated(){
                                let a = WeatherItem(data: item.element as! JSONDictionary)
                                weatherItems.append(a)
                            }
                            DispatchQueue.main.async {
                                self.delegate?.didWeatherAvailable(weatherItems: weatherItems)
                            }
                        }
                    }
                    
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
    }
    
}
