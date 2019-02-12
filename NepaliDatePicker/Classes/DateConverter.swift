//
//  DateConverter.swift
//  NSNCalendar
//
//  Created by f1 on 2/6/19.
//

import Foundation

public class DateConverter {
    
    var nepaliYear: Int = DateDataSource.startingNepaliYear
    var nepaliMonth: Int = DateDataSource.startingNepaliMonth
    var nepaliDay: Int = DateDataSource.startingNepaliDay
    
    public init() {
        
    }
    
    public func convertFromEnglishToNepali(date: String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd Z"
        let toDate = formatter.date(from: date!)
        let fromDate = formatter.date(from: "1944-01-01 +0000")
        var difference = DateDataSource.calculateDateDifference(fromDate: fromDate!, toDate: toDate!)
        print("Difference: \(difference)")
        
        while difference != 0 {
            let daysInIthMonth = DateDataSource.getSource()[nepaliYear]?[nepaliMonth]
            nepaliDay = nepaliDay + 1
            
            if nepaliDay > daysInIthMonth! {
                nepaliMonth = nepaliMonth + 1
                nepaliDay = 1
            }
            
            if nepaliMonth > 12  {
                nepaliYear = nepaliYear + 1
                nepaliMonth = 1
            }
            
            difference = difference - 1
            
        }
        let convertedDate = "\(nepaliYear)-\(nepaliMonth)-\(nepaliDay)"
        print("Converted from english to nepali: \(convertedDate)")
        return convertedDate
    }
    
    public  func convertFromNepaliToEnglish(date: String?) -> String {
        
        var splittedDate = date!.components(separatedBy: "-")
        
        let selectedYear = Int (splittedDate[0])
        let selectedMonth = Int (splittedDate[1])
        let selectedDay = Int (splittedDate[2])
        
        var difference = 0
        
        for year in EnglishToNepaliDateConverter.startingNepaliYear..<selectedYear! {
            for month in 1...12 {
                difference += DateDataSource.getSource()[year]![month]
            }
        }
        
        for month in EnglishToNepaliDateConverter.startingNepaliMonth..<(selectedMonth! + 1) {
            difference += DateDataSource.getSource()[selectedYear!]![month]
        }
        
        difference += selectedDay! - EnglishToNepaliDateConverter.startingNepaliDay
        
        print("Nepali Dates difference = \(difference)")
        
        var englishYear = EnglishToNepaliDateConverter.startingEnglishYear
        var englishMonth = EnglishToNepaliDateConverter.startingEnglishMonth
        var englishDay = EnglishToNepaliDateConverter.startingEnglishDay
        
        var endDayOfMonth = 0
        
        while difference != 0 {
            if isLeapYear(year: englishYear) {
                endDayOfMonth = EnglishToNepaliDateConverter.daysInMonthOfLeapYear[englishMonth]
            } else {
                endDayOfMonth = EnglishToNepaliDateConverter.daysInMonth[englishMonth]
            }
            
            englishDay = englishDay + 1
            
            if englishDay > endDayOfMonth {
                englishMonth = englishMonth + 1
                englishDay = 1
                
                if englishMonth > 12 {
                    englishYear = englishYear + 1
                    englishMonth = 1
                }
            }
            
            difference = difference - 1
        }
        let convertedDate = "\(englishYear)-\(englishMonth)-\(englishDay)"
        return convertedDate
    }
    
    func isLeapYear(year: Int) -> Bool {
        if year % 100 == 0 {
            return year % 400 == 0
        } else {
            return year % 4 == 0
        }
    }
    
}
