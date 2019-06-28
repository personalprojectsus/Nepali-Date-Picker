//
//  ViewController.swift
//  NepaliDatePicker
//
//  Created by NabinShrestha on 02/12/2019.
//  Copyright (c) 2019 NabinShrestha. All rights reserved.
//

import UIKit
import NepaliDatePicker

class ViewController: UIViewController {
    
    @IBOutlet weak var nepaliDatePicker: UIView!
    @IBOutlet weak var nepaliDate: UILabel!
    @IBOutlet weak var englishDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNepaliDatePickerView()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let date = Date()
        let calendar = Calendar.current
        let currentEnglishYear = calendar.component(.year, from: date)
        let currentEnglishMonth = calendar.component(.month, from: date)
        let currentEnglishDay = calendar.component(.day, from: date)
        
        let currentNepaliDate = DateConverter().getNepaliDate(englishDate: DateModel(year: currentEnglishYear, month: currentEnglishMonth, day: currentEnglishDay))
        
        guard let year = currentNepaliDate?.year, let month = currentNepaliDate?.month, let day = currentNepaliDate?.day else {return}
        
        self.nepaliDate.text = "\(year) - \(month) - \(day)"
        
        self.englishDate.text = DateUtils.getCurrentDateOnlyInString()
    }
    
    func setNepaliDatePickerView() {
        let nepaliDatePicker = NepaliDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216))
        nepaliDatePicker.delegate = self
        self.nepaliDatePicker.addSubview(nepaliDatePicker)
        self.addDoneToolbar(inView: self.nepaliDatePicker)
    }
    
    override func endEditing() {
        super.endEditing()
        self.nepaliDatePicker.isHidden = true
    }
}
extension ViewController: NepaliDatePickerDelegate {
    func pickerView(pickerView: UIView, selectedNepaliDate: String?) {
        self.nepaliDate.text = selectedNepaliDate
    }
    
    func pickerView(pickerView: UIView, englishYear: Int, englishMonth: Int, englishDay: Int) {
        self.englishDate.text = "\(englishYear)-\(englishMonth)-\(englishDay)"
    }
    
}
