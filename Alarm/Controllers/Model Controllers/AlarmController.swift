//
//  AlarmController.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
        //saveToPersistence()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
        //saveToPersistence()
    }
    
    func delete(alarm: Alarm) {
        if let index = self.alarms.firstIndex(where: {$0 == alarm}) {
            self.alarms.remove(at: index)
        }
        //saveToPersistence()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.isEnabled = !alarm.isEnabled
    }
}
