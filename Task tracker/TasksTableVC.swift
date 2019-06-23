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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // add new elements to array after save
        tasks = allKeys.map(UserDefaults.standard.getTask(with:)).compactMap { $0 }
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // delete from userDefaults
            let key = UserDefaults.standard.getKey(with: tasks[indexPath.row].self)
            UserDefaults.standard.remove(with: key)
            
            // delete from our tableView with bottom
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            tableView.reloadData()
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if let vc = segue.destination as? DetailVC {
//            let indexPath = self.tableView.indexPathForSelectedRow?.row
//
//            vc.headline.text = tasks[indexPath!].head
//            vc.inputDate.text = tasks[indexPath!].date
//            vc.taskStatus.text = tasks[indexPath!].status
//            vc.taskText.text = tasks[indexPath!].text
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "showDetail", sender: self)
//    }
    
}
