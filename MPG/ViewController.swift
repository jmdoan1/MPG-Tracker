//
//  ViewController.swift
//  MPG
//
//  Created by Justin Doan on 5/29/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//



import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var lblMileage: UILabel!
    @IBOutlet var lblCPM: UILabel!
    @IBOutlet var lblMPG: UILabel!
    @IBOutlet var lblCost: UILabel!
    @IBOutlet var sgmtCars: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var btnAdd: UIButton!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var indexForSegment = 0
    
    var cars: [Car] = []
    var fillups: [Fillup] = []
    var car = Car(nickName: nil, fillups: nil, firstMileage: nil, mileage: nil, totalCost: nil, totalMileage: nil, totalGallons: nil)
    var fillup: Fillup?
    
    var alertController:UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(btnAdd)
        
        tableView.delegate = self
        //tableView.dataSource = self
        
        if prefs.valueForKey("cars") != nil {
            let carsArray = prefs.objectForKey("cars") as! NSData
            self.cars = NSKeyedUnarchiver.unarchiveObjectWithData(carsArray) as! [Car]
        }
        
        sgmtCars.selectedSegmentIndex = indexForSegment
        
        self.updateSgmt()
    }
    
    func updateSgmt() {
        sgmtCars.removeAllSegments()
        if cars.count > 0 {
            for i in 0...(cars.count - 1) {
                sgmtCars.insertSegmentWithTitle(cars[i].nickName, atIndex: i, animated: false)
                
                cars[i].fillups.sortInPlace({ $0.date.compare($1.date) == .OrderedDescending })
                
                if cars[i].fillups.count > 0 {
                    let count = cars[i].fillups.count
                    cars[i].mileage = cars[i].fillups[0].mileage
                    cars[i].firstMileage = cars[i].fillups[count - 1].mileage
                    cars[i].totalMileage = cars[i].mileage! - cars[i].firstMileage!
                    
                    cars[i].totalCost = 0
                    cars[i].totalGallons = 0
                    
                    for x in 0...(cars[i].fillups.count - 1) {
                        
                        cars[i].fillups[x].mileDelta = 0
                        cars[i].fillups[x].MPG = 0
                        
                        if x != (cars[i].fillups.count - 1) {
                            cars[i].totalGallons = cars[i].totalGallons! + cars[i].fillups[x].gallons
                            cars[i].totalCost = cars[i].totalCost! + cars[i].fillups[x].priceTotal
                            
                            //TEST
                            cars[i].fillups[x].mileDelta = cars[i].fillups[x].mileage - cars[i].fillups[x + 1].mileage
                            cars[i].fillups[x].MPG = round((cars[i].fillups[x].mileDelta / cars[i].fillups[x].gallons) * 100) / 100
                        }
                    }
                }
            }
            car = cars[indexForSegment]
            
            sgmtCars.selectedSegmentIndex = indexForSegment
            
            self.selectSgmt(self)
        }
        sgmtCars.insertSegmentWithTitle("Add/Edit", atIndex: cars.count, animated: false)
    }
    
    @IBAction func selectSgmt(sender: AnyObject) {
        let arrayIndex = sgmtCars.selectedSegmentIndex
        
        if arrayIndex < cars.count {
            indexForSegment = arrayIndex
            
            car = cars[arrayIndex]
            
            if car.mileage != 0 {
                lblMileage.text = "\(car.mileage!)"
            } else {
                lblMileage.text = "N/A"
            }
            
            if car.totalGallons != 0 {
                if car.totalMileage != 0{
                    lblMPG.text = "\(round((car.totalMileage! / car.totalGallons!) * 100) / 100)"
                }
            } else {
                lblMPG.text = "N/A"
            }
            
            
            if car.totalCost != 0 {
                if car.totalMileage != 0 {
                    lblCPM.text = "$\(round((car.totalCost! / car.totalMileage!) * 100) / 100)"
                } else {
                    lblCPM.text = "N/A"
                }
            } else {
                lblCPM.text = "N/A"
            }
            
            if car.totalCost != 0 {
                lblCost.text = "$\(car.totalCost!)"
            } else {
                lblCost.text = "N/A"
            }
            
        } else {
            alertController = UIAlertController(title: "Would you like to add a vehicle", message: "or edit one ?", preferredStyle:UIAlertControllerStyle.Alert)
            
            alertController!.addAction(UIAlertAction(title: "ADD", style: UIAlertActionStyle.Default)
            { action -> Void in
                self.performSegueWithIdentifier("addCar", sender: self)
                })
            
            alertController!.addAction(UIAlertAction(title: "EDIT", style: UIAlertActionStyle.Default)
            { action -> Void in
                self.performSegueWithIdentifier("editCar", sender: self)
                })
            
            self.presentViewController(alertController!, animated: true, completion: nil)

            
            
        }
        
        self.tableView.reloadData()
        
    }
    
    @IBAction func addFillup(sender: AnyObject) {
        if cars.count > 0 {
            self.performSegueWithIdentifier("addFillup", sender: self)
        } else {
            alertController = UIAlertController(title: "Oops!", message:
                "You need to add a vehicle first", preferredStyle: UIAlertControllerStyle.Alert)
            alertController!.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController!, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addFillup" {
            let vc = segue.destinationViewController as? NewFillupViewController
            vc?.cars = cars
            vc!.car = cars[indexForSegment]
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if car.fillups != nil {
            return car.fillups.count
        } else {
            return 0
        }
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! FillupTableViewCell
        
        car.fillups.sortInPlace({ $0.date.compare($1.date) == .OrderedDescending })
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        let convertedDate = dateFormatter.stringFromDate(car.fillups[indexPath.row].date)
        
        cell.lblDate.text = "\(convertedDate)"
        cell.lblMPG.text = "\(car.fillups[indexPath.row].MPG) MPG"
        cell.lblPriceTotal.text = "$\(car.fillups[indexPath.row].priceTotal)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!;
        
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("FillupDetailViewController") as! FillupDetailViewController
        controller.cars = cars
        controller.car = car
        controller.fillups = car.fillups
        controller.fillup = car.fillups[indexPath.row]
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

