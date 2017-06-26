//
//  WeatherCollectionViewCell.swift
//  Weather Info
//
//  Created by surendra kumar on 6/25/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit
import SDWebImage


class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var red: UIView!
    @IBOutlet var green: UIView!
    @IBOutlet var yello: UIView!
    @IBOutlet var blue: UIView!
    @IBOutlet var chocklet: UIView!
    @IBOutlet var time: UILabel!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var id: UILabel!
    @IBOutlet var temp_type: UILabel!
    @IBOutlet var temp_minMAx: UILabel!
    @IBOutlet var temp_current: UILabel!
    @IBOutlet var cloudImage: UIImageView!
    @IBOutlet var date_month: UILabel!
    @IBOutlet var day_weakNUmber: UILabel!
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.updateUI()
    }
  
    var cellData: WeatherItem? {
        didSet {
            setCellData()
        }
    }

    func updateUI(){
        red.DrawMaskone()
        blue.DrawMaskone()
        green.DrawMasktwo()
        yello.DrawMasktwo()
        chocklet.DrawMasktwo()
    }
    
    func setCellData(){
        if let vhumidity = cellData?.humadity{
            self.humidity.text = "\(vhumidity)%"
        }else{
            self.humidity.text = "NA"
        }
        if let vpressure = cellData?.pressure{
            self.pressure.text = "\(vpressure) hPa"
        }else{
            self.pressure.text = "NA"
        }
        if let vid = cellData?.id{
            self.id.text = "\(vid)"
        }else{
            self.id.text = "NA"
        }
        
        // SET TEMP
        setTemp()
        // Set Date
        setDate()
        // SET IMAGE
        setImage()
       
    }
    
    func setImage(){
        guard let imgaename = cellData?.icon_name else {return}
        self.cloudImage.sd_setImage(with: URL(string: "https://openweathermap.org/img/w/\(imgaename).png"))
    }
    
    func setDate(){
     
        guard let dateString = cellData?.date else {
            self.date_month.text = "NA"
            self.day_weakNUmber.text = "NA"
            return
        }
    
        let myDate = stringToDate(dateString)
        let weekday = Calendar.current.component(.weekday, from: myDate!)
        let f = DateFormatter()
        let weekdayString = f.weekdaySymbols[weekday-1]
        
        
        let month = Calendar.current.component(.month, from: myDate!)
        let monthString = f.monthSymbols[month-1]
        let day = Calendar.current.component(.day, from: myDate!)
        
        self.date_month.text = "\(monthString)  \(day)"
        self.day_weakNUmber.text  = "\(weekdayString)"
        f.dateFormat = "HH:mm:ss"
        let a = f.string(from: myDate!)
        self.time.text = a
        }
    
    
    func stringToDate(_ str: String)->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat="yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: str)
    }
    
    func setTemp(){
        
        guard let temp = cellData?.temp  else {
            self.temp_current.text = "NA"; return
        }
        let defaults = UserDefaults.standard
        
        guard let userdefault = defaults.string(forKey: "type") else {
            self.temp_current.text = String(Int(round(temp)))
            self.temp_type.text = "\u{00B0}K"
            return
        }
       
        if userdefault == CELCIUS{
           let ctemp = TempConversion.sharedInstance.kelvintocelcius(K: temp)
            self.temp_current.text = String(Int(round(ctemp)))
            self.temp_type.text = "\u{00B0}C"
        }
        if userdefault == FORENHITE{
            let ctemp = TempConversion.sharedInstance.kelvintoForenhite(K: temp)
            self.temp_current.text = String(Int(round(ctemp)))
            self.temp_type.text = "\u{00B0}F"
        }
        
        if userdefault == KELVIN{
            self.temp_current.text = String(Int(round(temp)))
            self.temp_type.text = "\u{00B0}K"
        }
    }
}

extension UIView{
    
    func DrawMaskone(){
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.bottomLeft, .topRight],
                                    cornerRadii: CGSize(width: self.frame.size.width/2.5, height: self.frame.size.height/2.5))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
       DrawMask(n: self.superview!)
        
        }
    
    func DrawMasktwo(){
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: [.bottomRight, .topLeft],
                                    cornerRadii: CGSize(width: self.frame.size.width/2, height: self.frame.size.height/2))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
        DrawMask(n: self.superview!)
        }
    
    
        func DrawMask(n : UIView){
            
    
            // create new layer and apply Shadow to it
            let shadowLayer = CALayer()
            shadowLayer.masksToBounds = false
            shadowLayer.shadowRadius = 5.0
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = 1.0
            
            // To chache the rendered shado 
            // otherwise Drwaing will make App slow
            shadowLayer.shouldRasterize = true
            // add this layer to superView
            // add ur layer in layer again
            
            // Turn off it if view is a BUTTON
            self.removeFromSuperview()
            n.layer.insertSublayer(shadowLayer, at: 0)
            shadowLayer.insertSublayer(self.layer, at: 0)
            // add this new layer to superView
            
            //    yourlayer
            //    newLayer
            //    superViewLayer
            
            
            
            
            
        }
        

}
