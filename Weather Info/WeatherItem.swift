//
//  WeatherItem.swift
//  Weather Info
//
//  Created by surendra kumar on 6/24/17.
//  Copyright © 2017 weza. All rights reserved.
//

import Foundation

struct City {
    static var city_name            : String?
    static var lat                  : Double?
    static var long                 : Double?
    static var country_code         : String?
    

    public init(data : JSONDictionary){
        
        if  let cityName    = data["name"] as? String{
            City.city_name  = cityName
            
        }
        if let countryCode  = data["country"] as? String{
            City.country_code = countryCode
        }
        
        if  let coord       = data["coord"] as? JSONDictionary{
            if let lat      = coord["lat"] as? NSNumber{
                City.lat    = lat as? Double
            }
            if let long     = coord["lon"] as? NSNumber{
                City.long   = long as? Double
            }
        }
    }
}

class WeatherItem {
    

    private var _date        : String?
    private var _id          : Double?
    private var _icon_name   : String?
    private var _temp        : Double?
    private var _temp_min    : Double?
    private var _temp_max    : Double?
    private var _pressure    : Double?
    private var _humadity    : Double?
    
    
  
   
    
    public init(data : JSONDictionary){
        if let dt       = data["dt_txt"] as? String{
            self._date  = dt
        }
        
        if let weather              = data["weather"] as? JSONArray{
            if let vweather         = weather[0] as? JSONDictionary{
            
            if let wid              = vweather["id"] as? Double?{
                self._id            = wid
                
            }
            if let icon             = vweather["icon"] as? String{
                    self._icon_name = icon
                }
            }
        }
        
        if let main             = data["main"] as? JSONDictionary{
            if let temp         = main["temp"] as? Double{
                self._temp      = temp
            }
            if let tempMin      = main["temp_min"] as? Double{
                self._temp_min  = tempMin
            }
            if let tempMax      = main["temp_max"] as? Double{
                self._temp_max  = tempMax
            }
            if let humidity     = main["humidity"] as? Double{
                self._humadity  = humidity
            }
            if let pressure     = main["pressure"] as? Double{
                self._pressure  = pressure
            }
        }
    }
    
    var date : String? {
        return _date
    }
    
    var id : Double?{
        return _id
    }
    
    var icon_name : String?{
        return _icon_name
    }
    
    var temp : Double?{
        return _temp
    }
    
    var temp_min : Double?{
        return _temp_min
    }
    var temp_max : Double?{
        return _temp_max
    }
    var pressure : Double?{
        return _pressure
    }
    
    var humadity : Double?{
        return _humadity
    }
    
}
