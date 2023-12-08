//
//  NotificationsHandler.swift
//  Spotify-test
//
//  Created by mvitoriapereirac on 15/11/23.
//

import Foundation
import SwiftUI


class NotificationManager: NSObject, UNUserNotificationCenterDelegate, ObservableObject{
    //Singleton is required due to delegate
    static let shared: NotificationManager = NotificationManager()
    let notificationCenter = UNUserNotificationCenter.current()

    
    private override init(){
        super.init()
        //This assigns the delegate
        notificationCenter.delegate = self
    }
    
    func requestAuthorization() {
        print(#function)
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Access Granted")
            } else {
                print("Access Not Granted")
            }	
        }
    }
    
    func deleteNotifications(notificationIdentifier: String){
        print(#function)
        
        if notificationIdentifier == "Inactive" {
            notificationCenter.removePendingNotificationRequests(withIdentifiers: ["twoDaysInactivityNotification", "oneWeekInactivityNotification", "twoWeeksInactivityNotification"])
            print("Notifications cleared!")

        }
    }
    ///This is just a reusable form of all the copy and paste you did in your buttons. If you have to copy and paste make it reusable.
    func scheduleTriggerNotification(title: String, body: String, categoryIdentifier: String, dateComponents : DateComponents, repeats: Bool) {
        print(#function)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.categoryIdentifier = categoryIdentifier
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        notificationCenter.add(request)
        
    }
    
    func scheduleNotifications () {
        scheduleNotification(typeOfNotification: .timeIsUp)
    }
    
    func scheduleNotification(typeOfNotification: NotificationType) {
        let content = UNMutableNotificationContent()
        content.title = typeOfNotification.title
        content.body = typeOfNotification.body
        content.sound = typeOfNotification.sound
        var dateComp = DateComponents()
        dateComp.hour = 14
        dateComp.minute = 35
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: typeOfNotification.repeats)
        let request = UNNotificationRequest(identifier: typeOfNotification.identifier, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully")

            }
        }
    }
    ///Prints to console schduled notifications
    func printNotifications(){
        print(#function)
        notificationCenter.getPendingNotificationRequests { request in
            for req in request{
                if req.trigger is UNCalendarNotificationTrigger{
                    print((req.trigger as! UNCalendarNotificationTrigger).nextTriggerDate()?.description ?? "invalid next trigger date")
                }
            }
        }
    }
    //MARK: UNUserNotificationCenterDelegate
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler(.banner)
    }
}
