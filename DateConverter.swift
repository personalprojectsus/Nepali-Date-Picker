//
//  DateConverter.swift
//  NepaliDateConverter
//
//  Created by Nishan Niraula on 5/29/18.
//  Copyright © 2018 Nishan Niraula. All rights reserved.
//

import Foundation

public struct DateModel: CustomStringConvertible, Equatable {
    
    public let year: Int
    public let month: Int
    public let day: Int
    
    public init(year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    
    public var description: String {
        return "\(year)-\(month)-\(day)"
    }
    
    public static func == (lhs: DateModel, rhs: DateModel) -> Bool {
        return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
    }
}

public class DateConverter {
    
    public final let startNepaliDate = DateModel(year: 2000, month: 01, day: 01)
    public final let endNepaliDate = DateModel(year: 2090, month: 12, day: 30)
    
    public final let startEnglishDate = DateModel(year: 1943, month: 04, day: 14)
    public final let endEnglishDate = DateModel(year: 2034, month: 04, day: 13)
    
    private let calendar = Calendar.current
    private var nepaliDateMapCount: Int = 0

    public init() {
        nepaliDateMapCount = nepaliDateMap.count
    }
    
    /// Converts provided **English Date** to **Nepali Date**
    ///
    /// - Parameter englishDate: Date model for English Date
    /// - Returns: Returns DateModel object of Nepali Date if conversion is success. Else returns nil
    public func getNepaliDate(englishDate: DateModel) -> DateModel? {
        
        guard isEnglishDateWithinRange(date: englishDate) else {
            return nil
        }
        
        var startDateComponents = DateComponents()
        startDateComponents.year = startEnglishDate.year
        startDateComponents.month = startEnglishDate.month
        startDateComponents.day = startEnglishDate.day
        
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponents = DateComponents()
        endDateComponents.year = englishDate.year
        endDateComponents.month = englishDate.month
        endDateComponents.day = englishDate.day
        
        guard let endDate = calendar.date(from: endDateComponents) else {
            return nil
        }
        
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        var days = components.day ?? 0
        
        for i in 0..<nepaliDateMapCount {
            for j in 0...11 {
                if days > nepaliDateMap[i][j] {
                    days -= nepaliDateMap[i][j]
                } else {
                    return DateModel(year: i + startNepaliDate.year , month: j + 1, day: days + 1)
                }
            }
        }
        
        return nil
    }
    
    /// Converts provided **Nepali Date** to **English Date**
    ///
    /// - Parameter nepaliDate: Date model for Nepali Date
    /// - Returns: Returns DateModel object of English Date if conversion is success. Else returns nil
    public func getEnglishDate(nepaliDate: DateModel) -> DateModel? {
        
        guard isNepaliDateWithinRange(date: nepaliDate) else {
            return nil
        }
        
        var days = 0
        let maxYear = nepaliDate.year - startNepaliDate.year
        
        for i in 0...maxYear {
            
            for j in 0...11 {
                
                if i == maxYear && j == nepaliDate.month - 1 {
                    
                    days += nepaliDate.day - 1
                    
                    var comp = DateComponents()
                    comp.year = startEnglishDate.year
                    comp.month = startEnglishDate.month
                    comp.day = startEnglishDate.day
                    
                    let startDate = calendar.date(from: comp)!
                    let date = calendar.date(byAdding: .day, value: days, to: startDate)!
                    
                    let components = calendar.dateComponents([.day,.month,.year], from: date)
                    
                    return DateModel(year: components.year!, month: components.month!, day: components.day!)
                    
                } else {
                    days += nepaliDateMap[i][j]
                }
            }
        }
        return nil
    }
    
    
    /// Checks whether the English Date falls within the range which can be computed by this library
    ///
    /// - Parameter date: English Date model
    /// - Returns: true if date is within the range else false
    private func isEnglishDateWithinRange(date: DateModel) -> Bool {
        
        // Date should be within computational range
        if date.year > endEnglishDate.year || date.year < startEnglishDate.year {
            return false
        }
        
        if date.month < 1 || date.month > 12 {
            return false
        }
        
        // If the input is last valid english date
        if date.year == endEnglishDate.year {
            return date.month <= endEnglishDate.month && date.month >= 1 && date.day <= endEnglishDate.day && date.day >= 1
        }
        
        // If the input is the first valid english date
        if date.year == startEnglishDate.year {
            return date.month >= startEnglishDate.month && date.month <= 12 && date.day >= startEnglishDate.day && date.day <= 31
        }
        
        guard let actualDays = getNumberOfDaysInEnglishCalendar(year: date.year, month: date.month) else { return false }
        
        return date.day >= 1 && date.day <= actualDays
    }
    
    /// Checks whether the Nepali Date falls within the range which can be computed by this library
    ///
    /// - Parameter date: English Date model
    /// - Returns: true if date is within the range else false
    private func isNepaliDateWithinRange(date: DateModel) -> Bool {
        
        // Date should be within valid computational year
        if date.year > endNepaliDate.year || date.year < startNepaliDate.year {
            return false
        }
        
        // Validate for month here so that getting actual days for month
        // doesnot result in array index error
        if date.month < 1 || date.month > 12 {
            return false
        }
        
        // If the input is first valid nepali date
        if date.year == startNepaliDate.year {
            return date.month >= startNepaliDate.month && date.month <= 12
        }
        
        // If the input is last valid nepali date
        if date.year == endNepaliDate.year {
            return date.month <= endNepaliDate.month && date.month >= 1
        }
        
        // Finally validate for days
        let actualDays = getNumberOfDaysInNepaliCalendar(year: date.year, month: date.month)
        
        return date.day >= 1 && date.day <= actualDays
    }
    
    
    /// Computes the number of days in Nepali Calendar for given month & year
    ///
    /// - Parameters:
    ///   - year: Nepali Year from 2000 to 2090
    ///   - month: Nepali Month, 1 is Baisakh & 12 is Chaitra
    /// - Returns: Number of days
    private func getNumberOfDaysInNepaliCalendar(year: Int, month: Int) -> Int {
        return nepaliDateMap[year - startNepaliDate.year][month - 1]
    }
    
    
    /// Computes the number of days in English Calendar for given month & year
    ///
    /// - Parameters:
    ///   - year: English year from 1943 to 2034
    ///   - month: English month, 1 is Jan & 12 is December
    /// - Returns: Number of days
    private func getNumberOfDaysInEnglishCalendar(year: Int, month: Int) -> Int? {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        
        let date = Calendar.current.date(from: components)!
        
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count
    }
    
    
    /// Nepali Date Information used for conversion
    private let nepaliDateMap: [[Int]] =
        [
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 32, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [30, 32, 31, 32, 31, 31, 29, 30, 29, 30, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 29, 31],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 29, 30, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 30, 29, 31],
            [31, 31, 31, 32, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 29, 30, 29, 30, 30],
            [31, 32, 31, 32, 31, 30, 30, 30, 29, 29, 30, 30],
            [31, 31, 32, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            [31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
            [31, 31, 32, 31, 31, 30, 30, 30, 29, 30, 30, 30],
            [31, 32, 31, 32, 30, 31, 30, 30, 29, 30, 30, 30],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            [31, 31, 32, 31, 31, 31, 30, 30, 29, 30, 30, 30],
            [30, 31, 32, 32, 30, 31, 30, 30, 29, 30, 30, 30],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30],
            [30, 32, 31, 32, 31, 30, 30, 30, 29, 30, 30, 30]
    ]
}
