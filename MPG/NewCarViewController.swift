//
//  NewCarViewController.swift
//  MPG
//
//  Created by Justin Doan on 5/30/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController {
    
    var car = Car(nickName: nil, fillups: nil, firstMileage: nil, mileage: nil, totalCost: nil, totalMileage: nil, totalGallons: nil)
    var cars: [Car] = []
    
    var newCar = true
    
    var activeField: UITextField?
    
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var txtNickName: UITextField!
    
    let prefs = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNickName.layer.zPosition = 1

        if prefs.valueForKey("cars") != nil {
            let carsArray = prefs.objectForKey("cars") as! NSData
            self.cars = NSKeyedUnarchiver.unarchiveObjectWithData(carsArray) as! [Car]
        }
        
        if newCar == false {
            txtNickName.text = car.nickName
        }
        
        self.registerForKeyboardNotifications()
        
    }
    
    func registerForKeyboardNotifications() {
        //Adding notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewCarViewController.keyboardWasShown(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NewCarViewController.keyboardWillBeHidden(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func deregisterFromKeyboardNotifications() {
        //Removing notifies on keyboard appearing
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification)
    {
        //Need to calculate keyboard exact size due to Apple suggestions
        self.scrollView.scrollEnabled = true
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect : CGRect = self.view.frame
        aRect.size.height -= keyboardSize!.height
        if let activeFieldPresent = activeField
        {
            if (!CGRectContainsPoint(aRect, activeFieldPresent.frame.origin))
            {
                self.scrollView.scrollRectToVisible(activeFieldPresent.frame, animated: true)
            }
        }
        
        
    }
    
    
    func keyboardWillBeHidden(notification: NSNotification)
    {
        //Once keyboard disappears, restore original positions
        let info : NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.view.endEditing(true)
        self.scrollView.scrollEnabled = false
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField!)
    {
        activeField = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField!)
    {
        activeField = nil
    }
    
    
    
    
    @IBAction func save(sender: AnyObject) {
        if txtNickName.text != nil {
            
            car.nickName = txtNickName.text
            
            if car.fillups == nil {
                car.fillups = []
            }
            
            if newCar == true {
                car.firstMileage = 0
                car.mileage = 0
                car.totalCost = 0
                car.totalMileage = 0
                car.totalGallons = 0
                cars.append(car)
            }
            
            let carsArray = NSKeyedArchiver.archivedDataWithRootObject(cars)
            self.prefs.setObject(carsArray, forKey: "cars")
            
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
            let newIndex = cars.indexOf(car)
            if let index = newIndex {
                controller.indexForSegment = index
            }
            self.presentViewController(controller, animated: true, completion: nil)
            
        }
    }

}
