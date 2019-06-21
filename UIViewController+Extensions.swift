//
//  UIViewController+Extensions.swift
//  Pods
//
//  Created by Nabin Shrestha on 6/21/19.
//
//

import UIKit

public extension UIViewController {
    func addDoneToolbar(inView: UIView) {
        let toolBar = NepaliDatePickerToolbar.toolBar
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(endEditing))
        doneButton.setTitleTextAttributes([NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        self.view.addSubview(toolBar)
        toolBar.bottomAnchor.constraint(equalTo: inView.topAnchor).isActive = true
        toolBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        toolBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    @objc
    open func endEditing() {
        NepaliDatePickerToolbar.toolBar.removeFromSuperview()
    }
}
