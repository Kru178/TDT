//
//  NotificationCenter.swift
//  TDT
//
//  Created by Sergei Krupenikov on 18.04.2021.
//

import Foundation
import NotificationCenter

class NotificationScheduleCenter {
    
    static let shared = NotificationScheduleCenter()
    
    func scheduleNotification(for vc: UIViewController, movie: Movie, date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "It's time to watch \(movie.title)"
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
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("adding notification error: \(error)")
            } else {
                guard let safeDate = calendar.date(from: dateComponents) else { return }
                vc.showAlertOnMainThread(for: movie, date: safeDate)
            }
        }
    }
}
