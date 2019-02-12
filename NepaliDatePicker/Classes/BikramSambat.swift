//
//  BikramSambat.swift
//  nepali_calendar
//
//  Created by Aatish Rajkarnikar on 6/28/18.
//  Copyright © 2018 Aatish Rajkarnikar. All rights reserved.
//

import UIKit

public class BikramSambat {
    static let numberOfDaysInNepaliMonth = [
        2000:[30,32,31,32,31,30,30,30,29,30,29,31],
        2001:[31,31,32,31,31,31,30,29,30,29,30,30],
        2002:[31,31,32,32,31,30,30,29,30,29,30,30],
        2003:[31,32,31,32,31,30,30,30,29,29,30,31],
        2004:[30,32,31,32,31,30,30,30,29,30,29,31],
        2005:[31,31,32,31,31,31,30,29,30,29,30,30],
        2006:[31,31,32,32,31,30,30,29,30,29,30,30],
        2007:[31,32,31,32,31,30,30,30,29,29,30,31],
        2008:[31,31,31,32,31,31,29,30,30,29,29,31],
        2009:[31,31,32,31,31,31,30,29,30,29,30,30],
        2010:[31,31,32,32,31,30,30,29,30,29,30,30],
        2011:[31,32,31,32,31,30,30,30,29,29,30,31],
        2012:[31,31,31,32,31,31,29,30,30,29,30,30],
        2013:[31,31,32,31,31,31,30,29,30,29,30,30],
        2014:[31,31,32,32,31,30,30,29,30,29,30,30],
        2015:[31,32,31,32,31,30,30,30,29,29,30,31],
        2016:[31,31,31,32,31,31,29,30,30,29,30,30],
        2017:[31,31,32,31,31,31,30,29,30,29,30,30],
        2018:[31,32,31,32,31,30,30,29,30,29,30,30],
        2019:[31,32,31,32,31,30,30,30,29,30,29,31],
        2020:[31,31,31,32,31,31,30,29,30,29,30,30],
        2021:[31,31,32,31,31,31,30,29,30,29,30,30],
        2022:[31,32,31,32,31,30,30,30,29,29,30,30],
        2023:[31,32,31,32,31,30,30,30,29,30,29,31],
        2024:[31,31,31,32,31,31,30,29,30,29,30,30],
        2025:[31,31,32,31,31,31,30,29,30,29,30,30],
        2026:[31,32,31,32,31,30,30,30,29,29,30,31],
        2027:[30,32,31,32,31,30,30,30,29,30,29,31],
        2028:[31,31,32,31,31,31,30,29,30,29,30,30],
        2029:[31,31,32,31,32,30,30,29,30,29,30,30],
        2030:[31,32,31,32,31,30,30,30,29,29,30,31],
        2031:[30,32,31,32,31,30,30,30,29,30,29,31],
        2032:[31,31,32,31,31,31,30,29,30,29,30,30],
        2033:[31,31,32,32,31,30,30,29,30,29,30,30],
        2034:[31,32,31,32,31,30,30,30,29,29,30,31],
        2035:[30,32,31,32,31,31,29,30,30,29,29,31],
        2036:[31,31,32,31,31,31,30,29,30,29,30,30],
        2037:[31,31,32,32,31,30,30,29,30,29,30,30],
        2038:[31,32,31,32,31,30,30,30,29,29,30,31],
        2039:[31,31,31,32,31,31,29,30,30,29,30,30],
        2040:[31,31,32,31,31,31,30,29,30,29,30,30],
        2041:[31,31,32,32,31,30,30,29,30,29,30,30],
        2042:[31,32,31,32,31,30,30,30,29,29,30,31],
        2043:[31,31,31,32,31,31,29,30,30,29,30,30],
        2044:[31,31,32,31,31,31,30,29,30,29,30,30],
        2045:[31,32,31,32,31,30,30,29,30,29,30,30],
        2046:[31,32,31,32,31,30,30,30,29,29,30,31],
        2047:[31,31,31,32,31,31,30,29,30,29,30,30],
        2048:[31,31,32,31,31,31,30,29,30,29,30,30],
        2049:[31,32,31,32,31,30,30,30,29,29,30,30],
        2050:[31,32,31,32,31,30,30,30,29,30,29,31],
        2051:[31,31,31,32,31,31,30,29,30,29,30,30],
        2052:[31,31,32,31,31,31,30,29,30,29,30,30],
        2053:[31,32,31,32,31,30,30,30,29,29,30,30],
        2054:[31,32,31,32,31,30,30,30,29,30,29,31],
        2055:[31,31,32,31,31,31,30,29,30,29,30,30],
        2056:[31,31,32,31,32,30,30,29,30,29,30,30],
        2057:[31,32,31,32,31,30,30,30,29,29,30,31],
        2058:[30,32,31,32,31,30,30,30,29,30,29,31],
        2059:[31,31,32,31,31,31,30,29,30,29,30,30],
        2060:[31,31,32,32,31,30,30,29,30,29,30,30],
        2061:[31,32,31,32,31,30,30,30,29,29,30,31],
        2062:[30,32,31,32,31,31,29,30,29,30,29,31],
        2063:[31,31,32,31,31,31,30,29,30,29,30,30],
        2064:[31,31,32,32,31,30,30,29,30,29,30,30],
        2065:[31,32,31,32,31,30,30,30,29,29,30,31],
        2066:[31,31,31,32,31,31,29,30,30,29,29,31],
        2067:[31,31,32,31,31,31,30,29,30,29,30,30],
        2068:[31,31,32,32,31,30,30,29,30,29,30,30],
        2069:[31,32,31,32,31,30,30,30,29,29,30,31],
        2070:[31,31,31,32,31,31,29,30,30,29,30,30],
        2071:[31,31,32,31,31,31,30,29,30,29,30,30],
        2072:[31,32,31,32,31,30,30,29,30,29,30,30],
        2073:[31,32,31,32,31,30,30,30,29,29,30,31],
        2074:[31,31,31,32,31,31,30,29,30,29,30,30],
        2075:[31,31,32,31,31,31,30,29,30,29,30,30],
        2076:[31,32,31,32,31,30,30,30,29,29,30,30],
        2077:[31,32,31,32,31,30,30,30,29,30,29,31],
        2078:[31,31,31,32,31,31,30,29,30,29,30,30],
        2079:[31,31,32,31,31,31,30,29,30,29,30,30],
        2080:[31,32,31,32,31,30,30,30,29,29,30,30],
        2081:[31,31,32,32,31,30,30,30,29,30,30,30],
        2082:[30,32,31,32,31,30,30,30,29,30,30,30],
        2083:[31,31,32,31,31,30,30,30,29,30,30,30],
        2084:[31,31,32,31,31,30,30,30,29,30,30,30],
        2085:[31,32,31,32,30,31,30,30,29,30,30,30],
        2086:[30,32,31,32,31,30,30,30,29,30,30,30],
        2087:[31,31,32,31,31,31,30,30,29,30,30,30],
        2088:[30,31,32,32,30,31,30,30,29,30,30,30],
        2089:[30,32,31,32,31,30,30,30,29,30,30,30],
        2090:[30,32,31,32,31,30,30,30,29,30,30,30]
    ]
    
    
    public static func convertADToBS(date: Date) -> String {
        var nepaliYear = 2000
        var nepaliMonth = 9
        var nepaliDay = 17
        var weekDay = 7
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let initialEnglishDate = dateFormatter.date(from: "1944-01-01")
        
        var interval = DateComponents()
        interval.day = 1
        
        var numberOfDays = date.days(from: initialEnglishDate!)
        while numberOfDays != 0 {
            let daysInMonth = numberOfDaysInNepaliMonth[nepaliYear]![nepaliMonth - 1]
            nepaliDay = nepaliDay + 1
            if nepaliDay > daysInMonth {
                nepaliMonth = nepaliMonth + 1
                nepaliDay = 1
            }
            if nepaliMonth > 12 {
                nepaliYear = nepaliYear + 1
                nepaliMonth = 1
            }
            
            weekDay = weekDay + 1
            if weekDay > 7 {
                weekDay = 1
            }
            
            numberOfDays = numberOfDays - 1
            
            
        }
        return "\(nepaliYear)-\(nepaliMonth)-\(nepaliDay)"
    }
    
    /*static func convertBSToAD(year: Int, month: Int, day: Int)->Date?{
     if year < 2000 || year > 2090 || month < 1 || month > 12 { return nil}
     var calendar = Calendar(identifier: .gregorian)
     let dateFormatter = DateFormatter()
     //        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
     calendar.timeZone = TimeZone.current
     dateFormatter.dateFormat = "yyyy-MM-dd"
     
     var totalDays = 0
     for year in 2000..<year {
     totalDays += numberOfDaysInNepaliMonth[year]!.reduce(0,+)
     }
     for days in 1..<month{
     totalDays += numberOfDaysInNepaliMonth[year]![days-1]
     }
     totalDays += day
     
     let initialEnglishDate = dateFormatter.date(from: "1943-04-14")
     
     var interval = DateComponents()
     interval.day = totalDays
     return calendar.date(byAdding: interval, to: initialEnglishDate!)!
     }*/
    
    /*static func convertBSToAD(date: BSDate)->Date?{
     return convertBSToAD(year: date.year, month: date.month, day: date.day)
     }
     
     
     static func getBSDates(forYear year: Int, andMonth month: Int)->[BSDate?]{
     var calendar = Calendar(identifier: .gregorian)
     let dateFormatter = DateFormatter()
     //calendar.timeZone = TimeZone(secondsFromGMT: 0)!
     calendar.timeZone = TimeZone.current
     dateFormatter.dateFormat = "yyyy-MM-dd"
     
     var dates = [BSDate?]()
     if let englishDate = self.convertBSToAD(year: year, month: month, day: 1) {
     let weekday = calendar.component(.weekday, from: englishDate)
     for _ in 0..<weekday-1{
     dates.append(nil)
     }
     guard let numberOfDays = numberOfDaysInNepaliMonth[year]?[month - 1] else{return dates}
     for i in 0..<numberOfDays {
     let gregorianDate = calendar.date(byAdding: .day, value: i, to: englishDate)
     let weekday = calendar.component(.weekday, from: gregorianDate!)
     let date = BSDate(day: i+1, month: month, year: year, weekDay: weekday, gregorianDate: gregorianDate!)
     dates.append(date)
     }
     }
     return dates
     }*/
    
    
    static func getBSMonthName(for value: Int)->String{
        switch value {
        case 1:
            return "Baishak"
        case 2:
            return "Jestha"
        case 3:
            return "Asar"
        case 4:
            return "Shrawan"
        case 5:
            return "Bhadra"
        case 6:
            return "Asoj"
        case 7:
            return "Kartik"
        case 8:
            return "Mangsir"
        case 9:
            return "Poush"
        case 10:
            return "Magh"
        case 11:
            return "Falgun"
        case 12:
            return "Chaitra"
        default:
            return "N/A"
        }
    }
    
    static func getBSWeekday(for value: Int)->String{
        switch value {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "N/A"
        }
    }
}

extension Date{
    func days(from date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        //calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        calendar.timeZone = TimeZone.current
        return calendar.dateComponents([.day], from: date, to: self).day ?? 0
    }
}
