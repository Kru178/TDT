//
//  DateViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 04.04.2021.
//

import UIKit

class DateViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var movie : Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.timeZone = TimeZone.current
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        let date = datePicker.date
        NotificationScheduleCenter.shared.scheduleNotification(for: self, movie: movie, date: date)
    }
}



