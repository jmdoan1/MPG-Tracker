//
//  FillupDetailViewController.swift
//  MPG
//
//  Created by Justin Doan on 6/1/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class FillupDetailViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var cars: [Car] = []
    var car = Car(nickName: nil, fillups: nil, firstMileage: nil, mileage: nil, totalCost: nil, totalMileage: nil, totalGallons: nil)
    var fillups: [Fillup] = []
    var fillup = Fillup(date: nil, mileage: nil, mileDelta: nil, gallons: nil, priceGallon: nil, priceTotal: nil, MPG: nil)
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    let arrayTitles = ["Date:", "Mileage:", "Miles:", "MPG:", "Gallons:", "Cost:", "Price per gallon:"]
    
    var arrayData = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        let convertedDate = dateFormatter.stringFromDate(fillup.date)
        
        arrayData = ["\(convertedDate)", "\(fillup.mileage)", "\(fillup.mileDelta)", "\(fillup.MPG)", "\(fillup.gallons)", "$\(fillup.priceTotal)", "$\(fillup.priceGallon)"]
        
        self.tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayData.count > 0 {
            return arrayData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FillupDetailTableViewCell
        
        cell.lblTitle.text = arrayTitles[indexPath.row]
        cell.lblData.text = arrayData[indexPath.row] as? String
        
        return cell
    }
    
    @IBAction func btnEdit(sender: AnyObject) {
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("NewFillupViewController") as! NewFillupViewController
        controller.cars = cars
        controller.car = car
        controller.fillups = car.fillups
        controller.fillup = fillup
        controller.newFillup = false
        self.presentViewController(controller, animated: true, completion: nil)

    }
    
    
    @IBAction func btnDelete(sender: AnyObject) {
        
        car.fillups.removeAtIndex(car.fillups.indexOf(fillup)!)
        
        let carsArray = NSKeyedArchiver.archivedDataWithRootObject(cars)
        self.prefs.setObject(carsArray, forKey: "cars")
        
        self.performSegueWithIdentifier("doneDetail", sender: self)
        
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
