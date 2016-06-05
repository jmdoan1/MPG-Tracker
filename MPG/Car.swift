//
//  Car.swift
//  MPG
//
//  Created by Justin Doan on 5/29/16.
//  Copyright © 2016 Justin Doan. All rights reserved.
//

import Foundation

public class Car: NSObject {
    var nickName: String!
    var fillups: [Fillup]!
    var firstMileage: Double?
    var mileage: Double?
    var totalCost: Double?
    var totalMileage: Double?
    var totalGallons: Double?
    
    init(nickName: String!, fillups: [Fillup]?, firstMileage: Double?, mileage: Double?, totalCost: Double?, totalMileage: Double?, totalGallons: Double?) {
        self.nickName = nickName;
        self.fillups = fillups;
        self.firstMileage = firstMileage;
        self.mileage = mileage;
        self.totalCost = totalCost
        self.totalMileage = totalMileage
        self.totalGallons = totalGallons
    }
    
    required convenience public init(coder aDecoder: NSCoder) {
        let nickName = aDecoder.decodeObjectForKey("nickName") as! String
        let fillups = aDecoder.decodeObjectForKey("fillups") as? [Fillup]
        let firstMileage = aDecoder.decodeDoubleForKey("firstMileage")
        let mileage = aDecoder.decodeDoubleForKey("mileage")
        let totalCost = aDecoder.decodeDoubleForKey("totalCost")
        let totalMileage = aDecoder.decodeDoubleForKey("totalMileage")
        let totalGallons = aDecoder.decodeDoubleForKey("totalGallons")
        self.init(nickName: nickName, fillups: fillups, firstMileage: firstMileage, mileage: mileage, totalCost: totalCost, totalMileage: totalMileage, totalGallons: totalGallons)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(nickName as String, forKey: "nickName")
        aCoder.encodeObject(fillups, forKey: "fillups")
        aCoder.encodeDouble(firstMileage!, forKey: "firstMileage")
        aCoder.encodeDouble(mileage!, forKey: "mileage")
        aCoder.encodeDouble(totalCost!, forKey: "totalCost")
        aCoder.encodeDouble(totalMileage!, forKey: "totalMileage")
        aCoder.encodeDouble(totalGallons!, forKey: "totalGallons")
    }
}