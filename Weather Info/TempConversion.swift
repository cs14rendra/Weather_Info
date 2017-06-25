//
//  TempConversion.swift
//  Weather Info
//
//  Created by surendra kumar on 6/25/17.
//  Copyright © 2017 weza. All rights reserved.
//

import Foundation

class TempConversion {
    public static let sharedInstance = TempConversion()
    
    func kelvintocelcius(K : Double ) -> Double{
        return (K - 273)
    }
    
    func kelvintoForenhite(K : Double) -> Double{
        return  9.0/5.0 * (K - 273) + 32
    }
}
