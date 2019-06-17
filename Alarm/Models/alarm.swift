//
//  alarm.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

class Alarm {
    var fireDate: Date
    var name: String
    var isEnabled: Bool
    var UUID: String
    
    var fireTimeAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            let date = fireDate
            dateFormatter.locale = Locale(identifier: "en_US")
            return(dateFormatter.string(from: date))
        }
    }
    
    init(fireDate: Date, name: String, isEnabled: Bool, UUID: String) {
        self.fireDate = fireDate
        self.name = name
        self.isEnabled = isEnabled
        self.UUID = UUID
    }
}
