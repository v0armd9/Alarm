//
//  alarm.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    var name: String
    var isEnabled: Bool
    var uuid: String
    
    var fireTimeAsString: String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .none
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en_US")
            let date = fireDate
            return(dateFormatter.string(from: date))
        }
    }
    
    init(fireDate: Date, name: String, isEnabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.isEnabled = isEnabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        if lhs.fireDate != rhs.fireDate {return false}
        if lhs.name != rhs.name {return false}
        if lhs.isEnabled != rhs.isEnabled {return false}
        if lhs.uuid != rhs.uuid {return false}
        return true
    }
}
