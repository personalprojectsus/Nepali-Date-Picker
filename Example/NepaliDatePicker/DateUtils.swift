//
//  DateUtils.swift
//  NepaliDatePicker_Example
//
//  Created by Mac on 2/12/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DateUtils {
    
    static let formatter = DateFormatter()
    
    static let dateFormat1 = "yyyy-MM-dd HH:mm:ss"
    static let dateFormat2 = "dd-MM-yyyy HH:mm:ss"
    static let dateFormat3 = "yyyy-MM-dd HH:mm:ss +zzzz"
    static let dateFormat4 = "MMMM dd, yyyy"
    static let dateFormat5 = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    static let dateFormat6 = "dd MMM, yyyy E"
    static let dateFormat7 = "MMM, dd yyyy"
    static let dateFormat8 = "dd-MM-yyyy"
    static let dateOnlyFormat = "yyyy-MM-dd"
    static let timeOnlyFormat = "HH:mm:ss"
    
    
    static func getCurrentDateAndTime() -> String {
        formatter.dateFormat = dateFormat2
        return formatter.string(from: Date())
    }
    
    static func getCurrentDateOnly(value: String) -> String {
        formatter.dateFormat = dateFormat1
        
        let dateOnlyFormatter = DateFormatter()
        dateOnlyFormatter.dateFormat = dateOnlyFormat
        
        guard let date = formatter.date(from: value) else {
            return ""
        }
        
        return dateOnlyFormatter.string(from: date)
    }
    
    static func getCurrentTimeOnly(value: String) -> String {
        formatter.dateFormat = dateFormat1
        
        let timeOnlyFormatter = DateFormatter()
        timeOnlyFormatter.dateFormat = timeOnlyFormat
        
        guard let date = formatter.date(from: value) else {
            return ""
        }
        
        return timeOnlyFormatter.string(from: date)
    }
    
    static func getCurrentDateOnlyInString() -> String {
        formatter.dateFormat = DateUtils.dateOnlyFormat
        return formatter.string(from: Date())
    }
    
    static func getOneMonthEarlierDateOnly() -> String {
        formatter.dateFormat = DateUtils.dateOnlyFormat
        let fromDate = Calendar.current.date(byAdding: .day, value: -29, to: Date())!
        return formatter.string(from: fromDate)
    }
    
    static func getEarlierDateBy(offset: Int) -> String {
        formatter.dateFormat = DateUtils.dateOnlyFormat
        let fromDate = Calendar.current.date(byAdding: .day, value: -offset, to: Date())!
        return formatter.string(from: fromDate)
    }
    
    static func getAfterMonthBy(offset: Int) -> String {
        formatter.dateFormat = DateUtils.dateOnlyFormat
        let fromDate = Calendar.current.date(byAdding: .month, value: offset, to: Date())!
        return formatter.string(from: fromDate)
    }
    
    static func convertDate(from: String, to: String, date: String) -> String {
        formatter.dateFormat = from
        let convertedDate = formatter.date(from: date)
        formatter.dateFormat = to
        return formatter.string(from: convertedDate!)
    }
    
    static func validateDates(fromDate: String, toDate: String) -> Bool {
        formatter.dateFormat = dateOnlyFormat
        if let date1 = formatter.date(from: fromDate), let date2 = formatter.date(from: toDate) {
            return  date1 < date2 || date1 == date2
        }
        return false
    }
    
}
