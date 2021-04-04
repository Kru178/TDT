//
//  DateViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 04.04.2021.
//

import UIKit

class DateViewController: UIViewController {


    @IBOutlet weak var datePicker: UIDatePicker!
    
    let defaults = UserDefaults.standard
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .inline
    
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
        let date = datePicker.date
        defaults.setValue(date, forKey: "date")
        
        print(date.convertToStringFormat())
    }
    
    func scheduleNotification(for hour: Int, min: Int, date: DateComponents) {

        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = date.hour
        dateComponents.minute = date.minute
//        dateComponents.date = date.date
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
