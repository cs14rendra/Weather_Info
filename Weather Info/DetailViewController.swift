//
//  ViewController.swift
//  Weather Info
//
//  Created by surendra kumar on 6/24/17.
//  Copyright © 2017 weza. All rights reserved.
//

import UIKit


class ViewController: UIViewController,APIManagerDelegate {
    
    let manager = APIManager.sharedInstance
    let cellScaling: CGFloat = 0.75
    var weatherItems = [WeatherItem]()
    var vlat : Double = 0.0
    var vlog : Double = 0.0
    
    
    @IBOutlet var cordinarteView: UIView!
    @IBOutlet var up: UIView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var mycollection: UICollectionView!
    @IBOutlet var lat: UILabel!
    @IBOutlet var lon: UILabel!
    @IBOutlet var country: UILabel!
   
    override var prefersStatusBarHidden: Bool{return true}
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        designVieW()
        let screenSize = UIScreen.main.bounds.size
        let cellWidth  = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        let insetX     = (view.bounds.width - cellWidth) / 2.0
        let insetY     = (view.bounds.height - cellHeight) / 2.0
        let layout     = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        var doubleStr = String(format: "%.5f", vlat)
        self.lat.text = "Lat : \(doubleStr)"
        doubleStr = String(format: "%.5f", vlog)
        self.lon.text = "Lon : \(doubleStr)"
        
    }
    
    
    func didWeatherAvailable(weatherItems: [WeatherItem]) {
       self.weatherItems = weatherItems
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.country.text = City.city_name
        }
        
    }
    
    @IBOutlet var settings: UIButton!
    
    @IBAction func detailclose(segue : UIStoryboardSegue){
    collectionView.reloadData()
    }
    
}


// COLLECTION VIEW DLEGATE
extension  ViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return weatherItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WeatherCollectionViewCell
        cell.cellData = weatherItems[indexPath.row]
        
       
        return cell
    }
}


// HANDLE HORIZONTAL SCROLLING
extension ViewController
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

extension UIView{
    func drawmask(){
        self.layer.cornerRadius = 5.0
    }
}

extension ViewController{
    func designVieW(){
        self.up.alpha = 1.0
        self.cordinarteView.alpha = 1.0
        self.cordinarteView.DrawMasktwo()
    }
}

