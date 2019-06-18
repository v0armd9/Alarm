//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Darin Marcus Armstrong on 6/17/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }

    var alarmIsOn: Bool = true
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func updateViews() {
        guard let alarm = alarm else {return}
        datePicker.date = alarm.fireDate
        alarmNameTextField.text = alarm.name
        alarmIsOn = alarm.isEnabled
    }
    func setUpAlarmButton(){
        switch alarmIsOn {
        case true:
            enableButton.backgroundColor = UIColor.cyan
            enableButton.setTitle("Enabled", for: .normal)
        case false:
            enableButton.backgroundColor = UIColor.red
            enableButton.setTitle("Disable", for: .normal)
        }
    }
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let alarmName = alarmNameTextField.text else {return}
        if let alarm = alarm {
            AlarmController.sharedInstance.update(alarm: alarm, fireDate: datePicker.date, name: alarm.name, isEnabled: alarmIsOn)
        } else {
            AlarmController.sharedInstance.addAlarm(fireDate: datePicker.date, name: alarmName, isEnabled: alarmIsOn)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enableButtonTapped(_ sender: UIButton) {
        alarmIsOn = !alarmIsOn
        setUpAlarmButton()
    }
}

