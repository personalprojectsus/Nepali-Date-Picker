//
//  NepaliDatePicker.swift
//  NepaliDatePicker
//
//  Created by f1 on 2/12/19.
//

import UIKit

@objc(NepaliDatePickerDelegate)
public protocol NepaliDatePickerDelegate: UIPickerViewDelegate {
    /**
     A delegation method that is executed when NepaliDatePickerView is selected.
     - Parameter pickerView: A NepaliDatePickerView.
     - Parameter didSelectNepaliDate: An optional selected nepali date in String.
     */
    @objc
    func pickerView(pickerView: UIView, selectedNepaliDate: String?)
    
    /**
     A delegation method that is executed when NepaliDatePickerView is selected.
     - Parameter pickerView: A NepaliDatePickerView.
     - Parameter didSelectNepaliDate: An optional corresponding english date of selected nepali
     date in String.
     */
    @objc
    func pickerView(pickerView: UIView, correspondingEnglishDate: String?)
}


public class NepaliDatePicker: UIView {
    
    var nsnCalendarPickerView = UIPickerView()
    public weak var delegate: NepaliDatePickerDelegate?
    
    var currentYear: Int = 2019
    var currentMonth = 1
    var currentDay = 29
    
    var nepaliYear: Int = DateDataSource.startingNepaliYear
    var nepaliMonth: Int = DateDataSource.startingNepaliMonth
    var nepaliDay: Int = DateDataSource.startingNepaliDay
    
    var selectedYear: Int?
    var selectedMonth: Int?
    var selectedDay: Int?
    
    var heightOfPickerView:CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 160 : 120
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        self.nsnCalendarPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.frame.width, height: 216))
        self.nsnCalendarPickerView.delegate = self
        self.nsnCalendarPickerView.dataSource = self
        self.nsnCalendarPickerView.backgroundColor = UIColor.white
        addSubview(self.nsnCalendarPickerView)
        
        nsnCalendarPickerView.center = self.center
        nsnCalendarPickerView.autoresizingMask = []
        nsnCalendarPickerView.translatesAutoresizingMaskIntoConstraints = true
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let todayDate = Date()
        let stringTodayDate = formatter.string(from: todayDate)
        let toDate = formatter.date(from: stringTodayDate)
        print(todayDate)
        formatter.dateFormat = "yyyy-MM-dd Z"
        let fromDate = formatter.date(from: "1944-01-01 +0000")
        
        self.convertToNepaliDate(fromDate: fromDate, toDate: toDate)
        
        print("Year: \(nepaliYear)")
        print("\nMonth: \(nepaliMonth)")
        print("\nDay: \(nepaliDay)")
        
        self.nsnCalendarPickerView.selectRow(self.nepaliYear % 100, inComponent: 0, animated: true)
        self.nsnCalendarPickerView.selectRow(self.nepaliMonth - 1, inComponent: 1, animated: true)
        self.nsnCalendarPickerView.selectRow(self.nepaliDay - 1, inComponent: 2, animated: true)
        self.selectedYear = Array(DateDataSource.getSource().keys).sorted()[self.nsnCalendarPickerView.selectedRow(inComponent: 0)]
        self.selectedMonth = self.nsnCalendarPickerView.selectedRow(inComponent: 1)
        self.selectedDay = Array(1...32)[self.nsnCalendarPickerView.selectedRow(inComponent: 2)]
        print("\(selectedYear!)-\(selectedMonth!)-\(selectedDay!)")        
    }
}
extension NepaliDatePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return DateDataSource.getSource().count
        } else if component == 1 {
            return 12
        } else {
            return 32
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let yearData: [Int] = Array(DateDataSource.getSource().keys).sorted()
        if component == 0 {
            return String(yearData[row])
        } else if component == 1 {
            return DateDataSource.getMonths()[row]
        } else {
            return String(Array(1...32)[row])
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.selectedYear = Array(DateDataSource.getSource().keys).sorted()[self.nsnCalendarPickerView.selectedRow(inComponent: component)]
            if self.selectedYear! > self.nepaliYear {
                self.nsnCalendarPickerView.selectRow(self.nepaliYear % 100, inComponent: 0, animated: true)
            }
            let totalDaysInMonth = DateDataSource.getSource()[self.selectedYear!]![self.selectedMonth! + 1]
            if self.nsnCalendarPickerView.selectedRow(inComponent: 2) + 1 > totalDaysInMonth {
                self.nsnCalendarPickerView.selectRow(totalDaysInMonth - 1, inComponent: 2, animated: true)
                self.selectedDay = self.nsnCalendarPickerView.selectedRow(inComponent: 2) + 1
            }
        } else if component == 1 {
            let totalDaysInMonth = DateDataSource.getSource()[self.selectedYear!]![self.nsnCalendarPickerView.selectedRow(inComponent: 1) + 1]
            if self.nsnCalendarPickerView.selectedRow(inComponent: 2) + 1 > totalDaysInMonth {
                self.nsnCalendarPickerView.selectRow(totalDaysInMonth - 1, inComponent: 2, animated: true)
                self.selectedDay = self.nsnCalendarPickerView.selectedRow(inComponent: 2) + 1
            }
            self.selectedMonth = self.nsnCalendarPickerView.selectedRow(inComponent: component)
        } else {
            let totalDaysInMonth = DateDataSource.getSource()[self.selectedYear!]![self.nsnCalendarPickerView.selectedRow(inComponent: 1) + 1]
            if self.nsnCalendarPickerView.selectedRow(inComponent: 2) + 1 >= totalDaysInMonth {
                self.nsnCalendarPickerView.selectRow(totalDaysInMonth - 1, inComponent: 2, animated: true)
            }
            self.selectedDay = Array(1...32)[self.nsnCalendarPickerView.selectedRow(inComponent: component)]
        }
        print("\(selectedYear!)-\(DateDataSource.getMonths()[selectedMonth!])-\(selectedDay!)")
        let selectedNepaliDate = "\(selectedYear!)-\(selectedMonth!)-\(selectedDay!)"
        self.delegate?.pickerView(pickerView: self.nsnCalendarPickerView, selectedNepaliDate: selectedNepaliDate)
        self.delegate?.pickerView(pickerView: self.nsnCalendarPickerView, correspondingEnglishDate: DateConverter().convertFromNepaliToEnglish(date: selectedNepaliDate))
    }
    
    public func convertToEnglishDate(year: Int, month: Int, day: Int){
        var difference = 0
        
        for year in EnglishToNepaliDateConverter.startingNepaliYear..<year {
            for month in 1...12 {
                difference += DateDataSource.getSource()[year]![month]
            }
        }
        
        for month in EnglishToNepaliDateConverter.startingNepaliMonth..<(month + 1) {
            difference += DateDataSource.getSource()[self.selectedYear!]![month]
        }
        
        difference += day - EnglishToNepaliDateConverter.startingNepaliDay
        
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
        
        self.delegate?.pickerView(pickerView: self.nsnCalendarPickerView, correspondingEnglishDate: "\(englishYear)-\(englishMonth)-\(englishDay)")
        
    }
    
    
    func isLeapYear(year: Int) -> Bool {
        if year % 100 == 0 {
            return year % 400 == 0
        } else {
            return year % 4 == 0
        }
    }
    
    func convertToNepaliDate(fromDate: Date?, toDate: Date?) {
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
    }
}
