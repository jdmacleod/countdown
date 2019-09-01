//
//  ViewController.swift
//  countdown
//
//  Created by Jason MacLeod on 6/21/19.
//  Copyright © 2019 Jason MacLeod. All rights reserved.
//

import UIKit
import EventKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var editNavBar: UINavigationBar!
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Load saved data from userDefaults
        self.prepopulateData()
    }

    func prepopulateData() {
        let userDefaults = UserDefaults.standard
        let savedDate = userDefaults.value(forKey: "countdownDate") as! Date? ?? Date()
        datePicker.date = savedDate
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateText = formatter.string(from: savedDate)
        let days = computeDateDifference(date: savedDate)
        updateButton(labelText: dateText)
        countdownLabel.text = String(days)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        editNavBar.isHidden = true
        datePicker.isHidden = true
        self.prepopulateData()
    }
    
    @IBAction func selectDateAction(_ sender: Any) {
        editNavBar.isHidden = false
        datePicker.isHidden = false
    }
    
    @IBAction func saveDateAction(_ sender: UIBarButtonItem) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let dateText = formatter.string(from: datePicker.date)
        let days = computeDateDifference(date: datePicker.date)
        updateButton(labelText: dateText)
        countdownLabel.text = String(days)
        editNavBar.isHidden = true
        datePicker.isHidden = true
        let userDefaults = UserDefaults.standard
        userDefaults.set(datePicker.date, forKey: "countdownDate")
    }
    
    func updateButton(labelText: String) {
        dateButton.setTitle(labelText, for: .normal)
    }
    
    func computeDateDifference(date: Date) -> Int {
        let calendar = Calendar.current
        let date1 = Date()
        let date2 = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day, .hour], from: date1, to: date2)
        var days = Int(components.day ?? 0)
        if components.hour ?? 0 > 0 {
            days += 1
        }
        return days
    }
}

