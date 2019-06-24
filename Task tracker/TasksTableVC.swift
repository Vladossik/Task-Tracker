//
//  ViewController.swift
//  Task tracker
//
//  Created by Vladislava on 17/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit

class TasksTableVC: UITableViewController, UIPopoverPresentationControllerDelegate, FilterTableViewDelegate {

    var tasks: [Task] = []
    var filteredTasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keys = UserDefaults.standard.stringArray(forKey: "all-keys") ?? []
        tasks = keys.map(UserDefaults.standard.getTask(with:)).compactMap { $0 }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // add new elements to array after saving
        tasks = allKeys.map(UserDefaults.standard.getTask(with:)).compactMap { $0 }
        filteredTasks = tasks
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = filteredTasks[indexPath.row]
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
            
            let task = filteredTasks[indexPath.row]
            
            // delete from userDefaults
            let key = UserDefaults.standard.getKey(with: task.self)
            UserDefaults.standard.remove(with: key!)
            
            // delete from our tableView with bottom
            filteredTasks.remove(at: indexPath.row)
            tasks.removeAll(where: { $0 == task})
            tableView.deleteRows(at: [indexPath], with: .bottom)
            
            tableView.reloadData()
        }
    }
    
    // for selected cell with elements(data)
    var selectedTask: Task?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTask = filteredTasks[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    func didTappedStatus(_ status: String) {
        filteredTasks = tasks.filter { $0.status == status }
        tableView.reloadData()
    }
    
    @IBAction func filterButtonDidTap(_ sender: UIBarButtonItem) {
        let controller = FilterTableViewController(with: ["New task", "In progress", "Done"])
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 200, height: 130)
        controller.delegate = self
        
        let popoverController = controller.popoverPresentationController
        popoverController?.delegate = self
        popoverController?.sourceView = navigationController?.view
        popoverController?.sourceRect = CGRect(x: 8,
        y: 0,
        width: 100,
        height: 55)
        popoverController?.permittedArrowDirections = .up
        present(controller, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetail" {
            let vc = segue.destination as! DetailVC
            
            vc.task = selectedTask
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
