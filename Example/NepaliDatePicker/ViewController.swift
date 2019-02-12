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
        
        self.nepaliDate.text = DateConverter().convertFromEnglishToNepali(date: DateUtils.getCurrentDateOnlyInString() + " +0000")
        
        self.englishDate.text = DateUtils.getCurrentDateOnlyInString()
        
    }
    
    func setNepaliDatePickerView() {
        let nepaliDatePicker = NepaliDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216))
        nepaliDatePicker.delegate = self
        self.nepaliDatePicker.addSubview(nepaliDatePicker)
    }
}
extension ViewController: NepaliDatePickerDelegate {
    func pickerView(pickerView: UIView, selectedNepaliDate: String?) {
        self.nepaliDate.text = selectedNepaliDate
    }
    
    func pickerView(pickerView: UIView, correspondingEnglishDate: String?) {
        self.englishDate.text = correspondingEnglishDate
    }
    
}
