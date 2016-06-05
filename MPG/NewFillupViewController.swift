//
//  NewFillupViewController.swift
//  MPG
//
//  Created by Justin Doan on 5/30/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class NewFillupViewController: UIViewController {
    
    
    @IBOutlet var lblCar: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var txtMileage: UITextField!
    @IBOutlet var txtGallons: UITextField!
    @IBOutlet var txtPriceTotal: UITextField!
    
    var newFillup = true
    
    var cars: [Car] = []
    var car = Car(nickName: nil, fillups: nil, firstMileage: nil, mileage: nil, totalCost: nil, totalMileage: nil, totalGallons: nil)
    var fillups: [Fillup] = []
    var fillup = Fillup(date: nil, mileage: nil, mileDelta: nil, gallons: nil, priceGallon: nil, priceTotal: nil, MPG: nil)
    
    
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblCar.text = "For \(car.nickName)"
        
        if car.fillups == nil {
            car.fillups = []
        }
        
        if newFillup == false {
            datePicker.date = fillup.date
            txtMileage.text = "\(fillup.mileage)"
            txtGallons.text = "\(fillup.gallons)"
            txtPriceTotal.text = "\(fillup.priceTotal)"
        }
        
    }
    
    
    @IBAction func save(sender: AnyObject) {
        fillup.date =  datePicker.date
        fillup.mileage = Double(txtMileage.text!)
        fillup.gallons = Double(txtGallons.text!)
        fillup.priceTotal = Double(txtPriceTotal.text!)
        fillup.mileDelta = 0
        fillup.priceGallon = round((Double(txtPriceTotal.text!)! / Double(txtGallons.text!)!) * 1000) / 1000
        fillup.MPG = 0
        
        if newFillup == true {
            car.fillups.append(fillup)
        }
        
        let carsArray = NSKeyedArchiver.archivedDataWithRootObject(cars)
        self.prefs.setObject(carsArray, forKey: "cars")
        
        self.performSegueWithIdentifier("doneFillup", sender: self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
