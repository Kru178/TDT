//
//  DateViewController.swift
//  TDT
//
//  Created by Sergei Krupenikov on 04.04.2021.
//

import UIKit

class DateViewController: UIViewController, UNUserNotificationCenterDelegate {
 
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var movieTitle: String = ""
    let center = UNUserNotificationCenter.current()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.preferredDatePickerStyle = .inline
        datePicker.timeZone = TimeZone.current
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("movie: \(movieTitle)")
        let date = datePicker.date
        print(date.convertToDateAndTime())
        scheduleNotification(date: date)
    }
    
    
    func scheduleNotification(date: Date) {
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder!"
        content.body = "It's time to watch \(movieTitle)"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        var dateComponents = DateComponents()
        dateComponents.timeZone = TimeZone.current
        dateComponents.hour = hour
        dateComponents.minute = minutes
        dateComponents.day = day
        dateComponents.month = month
        dateComponents.year = year
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)  { (error) in
            if let error = error {
                print("adding notification error: \(error)")
            } else {
                print("successfully added notification")
                DispatchQueue.main.async {
                    guard let safeDate = calendar.date(from: dateComponents) else {return}
                    self.showAlert(for: safeDate)
                }
            }
        }
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    
    func showAlert(for date: Date) {
        let str = date.convertToDateAndTime()
        let ac = UIAlertController(title: "Scheduled!", message: "We will remind you to watch the \(movieTitle) movie on \(str)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        ac.addAction(action)
        present(ac, animated: true)
    }
}
