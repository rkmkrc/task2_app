//
//  NotificationViewModel.swift
//  task2_app
//
//  Created by Erkam Karaca on 3.09.2023.
//

import Foundation
import UserNotifications


class NotificationViewModel: ObservableObject {
    static let shared = NotificationViewModel()
    
    func scheduleAlarm(selectedHour: Int, selectedMinute: Int, completion: @escaping (Bool) -> Void) {
        let content = UNMutableNotificationContent()
        content.title = "Wake Up"
        content.body = "Time to wake up!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "song.mp3"))
        
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHour
        dateComponents.minute = selectedMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
                completion(false)
            } else {
                print("Alarm scheduled successfully")
                completion(true)
            }
        }
    }
    
    func checkForPermission(selectedHour: Int, selectedMinute: Int, completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.scheduleAlarm(selectedHour: selectedHour, selectedMinute: selectedMinute, completion: completion)
            case .denied:
                completion(false)
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.scheduleAlarm(selectedHour: selectedHour, selectedMinute: selectedMinute, completion: completion)
                    } else {
                        completion(false)
                    }
                }
            default:
                completion(false)
            }
        }
    }
}
