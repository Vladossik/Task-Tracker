//
//  DetailViewController.swift
//  Task tracker
//
//  Created by Vladislava on 17/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var inputDate: UITextField!
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var taskStatus: UITextField!
    @IBOutlet weak var taskText: UITextView!
    
    @IBAction func saveInfoTask(_ sender: Any) {
//        let head = headline.text
//        let date = inputDate.text
        
    }
    
    
    private var datePicker: UIDatePicker?
    var picker = UIPickerView()
    var state = ["New task", "In progress", "Done"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        datePicker?.addTarget(self, action: #selector(DetailViewController.dateChanged(datePcker:)), for: .valueChanged)
        
        // hide datePicker after tap on view
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.viewTap(gestureRecognizer:)))
        view.addGestureRecognizer(tap)
        
        //save in datePcker textField
        inputDate.inputView = datePicker
        
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
