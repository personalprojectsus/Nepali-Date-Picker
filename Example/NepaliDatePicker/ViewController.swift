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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNepaliDatePickerView()
        
    }
    
    func setNepaliDatePickerView() {
        let nepaliDatePicker = NepaliDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 216))
        nepaliDatePicker.delegate = self
        self.nepaliDatePicker.addSubview(nepaliDatePicker)
    }
}
extension ViewController: NepaliDatePickerDelegate {
    func pickerView(pickerView: UIView, selectedNepaliDate: String?) {
        
    }
    
    func pickerView(pickerView: UIView, correspondingEnglishDate: String?) {
        
    }
    
    
}
