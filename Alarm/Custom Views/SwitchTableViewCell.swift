//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    func updateViews() {
        guard let alarm = alarm else {return}
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.isEnabled
    }
    
}
