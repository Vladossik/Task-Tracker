//
//  TableViewCell.swift
//  Tasktracker
//
//  Created by Vladislava on 18/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
   
    func setTask(_ task: Task) {
        headLabel.text = task.head
        statusLabel.text = task.status
        dateLabel.text = task.date
        aboutLabel.text = task.text
    }

}
