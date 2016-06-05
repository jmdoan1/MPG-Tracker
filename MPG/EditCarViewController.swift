//
//  EditCarViewController.swift
//  MPG
//
//  Created by Justin Doan on 6/2/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class EditCarViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    let prefs = NSUserDefaults.standardUserDefaults()
    
    var cars: [Car] = []
    
    var alertController = UIAlertController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        if prefs.valueForKey("cars") != nil {
            let carsArray = prefs.objectForKey("cars") as! NSData
            self.cars = NSKeyedUnarchiver.unarchiveObjectWithData(carsArray) as! [Car]
        }

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cars.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EditCarTableViewCell
        
        // Configure the cell...
        //let car = cars[indexPath.row]
        cell.lblNickName.text = cars[indexPath.row].nickName
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!;
        
        let controller = self.storyboard?.instantiateViewControllerWithIdentifier("NewCarViewController") as! NewCarViewController
        controller.car = cars[indexPath.row]
        controller.newCar = false
        controller.cars = cars
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            alertController = UIAlertController(title: "Are you sure you want to delete \(cars[indexPath.row].nickName)", message: "this can not be undone", preferredStyle:UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default)
            { action -> Void in
                
                self.cars.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                
                let carsArray = NSKeyedArchiver.archivedDataWithRootObject(self.cars)
                self.prefs.setObject(carsArray, forKey: "cars")
                })
            
            alertController.addAction(UIAlertAction(title: "Maybe not..", style: UIAlertActionStyle.Default)
            { action -> Void in
                //
                })
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
