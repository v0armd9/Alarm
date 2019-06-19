//
//  AlarmController.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func cancelUserNotifications(for alarm: Alarm)
    func scheduleUserNotifications(for alarm: Alarm)
}

class AlarmController: AlarmScheduler {
    
    init() {
        loadFromPersistentStore()
    }
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
        if newAlarm.isEnabled {
            scheduleUserNotifications(for: newAlarm)
        } else {
            cancelUserNotifications(for: newAlarm)
        }
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStore()
        }
    
    func delete(alarm: Alarm) {
        if let index = self.alarms.firstIndex(where: {$0 == alarm}) {
            self.alarms.remove(at: index)
        }
        cancelUserNotifications(for: alarm)
        saveToPersistentStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.isEnabled = !alarm.isEnabled
        if alarm.isEnabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "Alarm.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(AlarmController.sharedInstance.alarms)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedAlarm = try jsonDecoder.decode([Alarm].self, from: data)
            self.alarms = decodedAlarm
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
}

extension AlarmScheduler {
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Alarm"
        notificationContent.body = "Your alarm is ringing"
        
        
        let date = alarm.fireDate
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
}
