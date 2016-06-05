//
//  Fillup.swift
//  MPG
//
//  Created by Justin Doan on 5/29/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import Foundation

public class Fillup: NSObject {
    var date: NSDate!
    var mileage: Double!
    var mileDelta: Double!
    var gallons: Double!
    var priceGallon: Double!
    var priceTotal: Double!
    var MPG: Double!
    
    init(date: NSDate!, mileage: Double!, mileDelta: Double!, gallons: Double!, priceGallon: Double!, priceTotal: Double!,MPG: Double?) {
        self.date = date
        self.mileage = mileage
        self.mileDelta = mileDelta
        self.gallons = gallons
        self.priceGallon = priceGallon
        self.priceTotal = priceTotal
        self.MPG = MPG
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let date = aDecoder.decodeObjectForKey("date") as! NSDate
        let mileage = aDecoder.decodeDoubleForKey("mileage")
        let mileDelta = aDecoder.decodeDoubleForKey("mileDelta")
        let gallons = aDecoder.decodeDoubleForKey("gallons")
        let priceGallon = aDecoder.decodeDoubleForKey("priceGallon")
        let priceTotal = aDecoder.decodeDoubleForKey("priceTotal")
        let MPG = aDecoder.decodeDoubleForKey("MPG")
        self.init(date: date, mileage: mileage, mileDelta: mileDelta, gallons: gallons, priceGallon: priceGallon, priceTotal: priceTotal, MPG: MPG)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(date as NSDate, forKey: "date")
        aCoder.encodeDouble(mileage, forKey: "mileage")
        aCoder.encodeDouble(mileDelta, forKey: "mileDelta")
        aCoder.encodeDouble(gallons, forKey: "gallons")
        aCoder.encodeDouble(priceGallon, forKey: "priceGallon")
        aCoder.encodeDouble(priceTotal, forKey: "priceTotal")
        aCoder.encodeDouble(MPG, forKey: "MPG")
    }
}