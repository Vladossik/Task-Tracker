//
//  DetailViewController.swift
//  Task tracker
//
//  Created by Vladislava on 17/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var taskStatus: UITextField!
    @IBOutlet weak var taskText: UITextView!
    
    @IBAction func saveInfoTask(_ sender: Any) {
        
        // check if all fields are filled
        if headline.text == nil || inputDate.text == nil || taskStatus.text == nil || taskText.text == nil || taskText.text == "About task.." {
            
            alertTask(message: "All fields must be filled")
            return
            
        } else {
            // if task already exists
            if let keyTask = UserDefaults.standard.getKey(with: task!) {
                // cell changes
                let task = Task(head: headline.text!, date: inputDate.text!, status: taskStatus.text!, text: taskText.text!)
                
                // update task with changes
                UserDefaults.standard.update(task: task, with: keyTask)
                
                alertTask(message: "Task was updated")
                
            } else {
                // if it's new one, create key
                let newKey = UUID().uuidString
                
                // save task to UserDefaults
                UserDefaults.standard.save(task: task!, with: newKey)
                UserDefaults.standard.synchronize()
                
                alertTask(message: "Task was saved")
            }
        }
    }
    
    // default alert for different cases
    func alertTask(message: String) {
        
        let myAlert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let okey = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        myAlert.addAction(okey)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    private var datePicker: UIDatePicker?
    var picker = UIPickerView()
    var state = ["New task", "In progress", "Done"]
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = task {
            // if task from cell
            headline.text = task.head
            inputDate.text = task.date
            taskStatus.text = task.status
            taskText.text = task.text
            
        } else {
            // new task
            task = Task(head: headline.text!, date: inputDate.text!, status: taskStatus.text!, text: taskText.text!)
        
            // add placeholder to TextView
            taskText.delegate = self
            taskText.text = "About task.."
            taskText.textColor = UIColor.lightGray
            
            // hide placeholder while adding text
            textViewDidBeginEditing(taskText)
            //return back if text is empty
            textViewDidEndEditing(taskText)
            
            // select task Status with pickerView
            picker.delegate = self
            picker.dataSource = self
            taskStatus.inputView = picker

            // create datePicker for pick date
            datePicker = UIDatePicker()
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(DetailVC.dateChanged(datePcker:)), for: .valueChanged)
            
            // hide datePicker after tap on view
            let tap = UITapGestureRecognizer(target: self, action: #selector(DetailVC.viewTap(gestureRecognizer:)))
            view.addGestureRecognizer(tap)
            
            //save in datePcker textField
            inputDate.inputView = datePicker
        }
        
        // add border to textView
        taskText.layer.borderColor = UIColor.lightGray.cgColor
        taskText.layer.cornerRadius = 5.0
        taskText.layer.borderWidth = 0.5
    }
    
    // the placeholder disappear when your UITextView is selected
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    // if the text view is empty, set placeholder
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "About task.."
            textView.textColor = UIColor.lightGray
        }
    }
    
    // for pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // elements in PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return state.count
    }
    // our state in PickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return state[row]
    }
    // hide after selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        taskStatus.text = state[row]
        self.view.endEditing(true)
    }
    
    // hide after selected date
    @objc func viewTap(gestureRecognizer : UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    // for datePicker
    @objc func dateChanged(datePcker: UIDatePicker) {
        let formatOfdata = DateFormatter()
        formatOfdata.dateFormat = "MM/dd/yyyy"
        
        inputDate.text = formatOfdata.string(from: datePicker!.date)
        view.endEditing(true)
    }
    
}
