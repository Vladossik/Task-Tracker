//
//  ViewController.swift
//  Task tracker
//
//  Created by Vladislava on 17/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit

class TasksTableVC: UITableViewController {

    var tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keys = UserDefaults.standard.stringArray(forKey: "all-keys") ?? []
        tasks = keys.map(UserDefaults.standard.getTask(with:)).compactMap { $0 }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell {
            cell.setTask(task)
            return cell
        } else {
            return UITableViewCell(style: .default, reuseIdentifier: "\(TableViewCell.self)")
        }
    }
    

}
