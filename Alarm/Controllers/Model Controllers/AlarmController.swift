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
    
    var mockAlarms: [Alarm] = {
        let nineAM = Alarm(fireDate: Date(), name: "Morning Treat", isEnabled: true)
        let noonPM = Alarm(fireDate: Date(), name: "Lunch Time", isEnabled: true)
        let ninePM = Alarm(fireDate: Date(), name: "Bed Time", isEnabled: false)
        
        return [nineAM, noonPM, ninePM]
    }()
    
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool) -> Alarm {
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
        return newAlarm
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
}
