//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    
    weak var cellDelegate: SwitchTableViewCellDelegate?
    
    var alarm: Alarm? {
        didSet {
            guard let alarm = alarm else {return}
            updateViews(alarm: alarm)
        }
    }

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    func updateViews(alarm: Alarm) {
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.isEnabled
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        cellDelegate?.switchCellSwitchValueChanged(cell: self)
    }
    
}


