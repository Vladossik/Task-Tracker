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
        
        // add new elements to array after saving
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
            // fill cell with method from TableViewCell
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
            UserDefaults.standard.remove(with: key!)
            
            // delete from our tableView with bottom
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            tableView.reloadData()
        }
    }
    
    // for selected cell with elements(data)
    var selectedTask: Task?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTask = tasks[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showDetail" {
            let vc = segue.destination as! DetailVC

            vc.task = selectedTask
        }
    }

}
