//
//  Date.swift
//  TaskIt
//
//  Created by Koen Hendriks on 11/11/14.
//  Copyright (c) 2014 Koen Hendriks. All rights reserved.
//

import Foundation

class Date {
    
    class func from(#year:Int, month:Int, day:Int) -> NSDate{
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalender = NSCalendar(identifier: NSGregorianCalendar)!
        var date = gregorianCalender.dateFromComponents(components)
        
        return date!
    }
    
    class func toString(#date:NSDate) -> String{
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}