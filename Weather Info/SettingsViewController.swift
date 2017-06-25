//
//  SettingsViewController.swift
//  Weather Info
//
//  Created by surendra kumar on 6/25/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet var mypicker: UIPickerView!
    var pickerData = ["SELECT TYPE",CELCIUS, KELVIN, FORENHITE]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypicker.delegate = self
        mypicker.dataSource = self
    }

   
    // PICKER VIEW DELEGATE
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
        //if (row == 0) {return}
        let defaults = UserDefaults.standard
        defaults.set(pickerData[row], forKey: "type")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }
}
