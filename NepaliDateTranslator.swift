//
//  NepaliDateTranslator.swift
//  NepaliDateConverter
//
//  Created by Nishan Niraula on 5/29/18.
//  Copyright © 2018 Nishan Niraula. All rights reserved.
//

import Foundation

public class NepaliDateTranslator {
    
    /// Nepali digits in devanagiri/unicode
    public let digits = [
        "०", "१", "२", "३", "४", "५", "६", "७","८", "९"]
    
    /// Nepali months in devanagiri/unicode
    public let months = [
        "बैशाख", "जेष्ठ", "अषाढ", "श्रावण", "भाद्र", "असोज", "कात्तिक", "मंसिर", "पौष", "माघ", "फाल्गुन", "चैत्र"]
    
    /// Nepali days in devanagiri/unicode
    public let days = [
        "आईत", "सोम", "मंगल", "बुध", "बिही", "शुक्र", "शनि"]
    
    public init() {
        
    }
    
    /// Get the name of month in Nepali
    ///
    /// - Parameter month: Range of month [1-12] where 1 is baisakh
    /// - Returns: Name of month in Nepali
    public func getMonth(month:Int) -> String {
        return months[month - 1]
    }
    
    /// Get the name of day in Nepali
    ///
    /// - Parameter day: Range of day [1-7] where 1 is Sunday
    /// - Returns: Name of day in Nepali
    public func getDay(day: Int) -> String {
        return days[day - 1]
    }
    
    /// Get the number in Nepali
    ///
    /// - Parameter number: Number in English language
    /// - Returns: Number in Nepali
    public func getNumber(number: Int) -> String {
        
        let numberStr = "\(number)"
        
        let nepaliStrArr = numberStr.map { (char) -> String in
            
            let charStr = "\(char)"
            if let index = Int(charStr) {
                return digits[index]
            } else {
                return charStr
            }
        }
        
        return nepaliStrArr.joined()
    }
}
