//
//  File.swift
//  Tasktracker
//
//  Created by Vladislava on 18/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import Foundation
import UIKit

struct Task : Equatable {
    var head : String
    var date : String
    var status : String
    var text : String
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        if lhs.head == rhs.head && lhs.date == rhs.date &&
            lhs.status == rhs.status && lhs.text == rhs.text {
            return true
        } else {
            return false
        }
    }
}

var userDefaults = UserDefaults.standard
// array with all keys
var allKeys = UserDefaults.standard.stringArray(forKey: "all-keys") ?? []

var sharedDefaults = UserDefaults(suiteName: "group.sharingForTodayExtension")

extension UserDefaults {
    
    func save(task: Task, with key: String) {
        let payload = [
            "head" : task.head,
            "date" : task.date,
            "status" : task.status,
            "text" : task.text
        ]
        userDefaults.set(payload, forKey: key)
        allKeys.append(key)
        userDefaults.set(allKeys, forKey: "all-keys")
        
        userDefaults.synchronize()
    }
    
    func getTask(with key: String) -> Task? {
        guard
            let payload = userDefaults.dictionary(forKey: key) as? [String: String],
            let head = payload["head"],
            let date = payload["date"],
            let status = payload["status"],
            let text = payload["text"]
        else {
                return nil
        }
        return Task(head: head, date: date, status: status, text: text)
    }
    
    func getKey(with task: Task) -> String? {
        var keyTask: String?
        for i in allKeys {
            if task == userDefaults.getTask(with: i) {
                keyTask = i
            }
        }
        if keyTask != nil {
            return keyTask
        } else {
            return nil
        }
    }
    
    func remove(with key: String) {
        userDefaults.removeObject(forKey: key)
        if let index = allKeys.firstIndex(of: key) {
            allKeys.remove(at: index)
        }
        userDefaults.set(allKeys, forKey: "all-keys")
        
        userDefaults.synchronize()
    }
    
    func update(task: Task, with key: String) {
        remove(with: key)
        save(task: task, with: key)
    }
    
    func minTaskByDate() -> Task {
        
//        //Create a date formatter to convert our date strings to Date objects
//        let df = DateFormatter()
//        df.dateFormat = "MM/dd/yyyy"
//        let array: [String:]
//        let sortedArray = task
//        //First map to an array tuples: [(Date, [String:Int]]
//            .map{(df.date(from: $0.task)!, [$0.key:$0.value])}
        
        
//        let dayTotalDicTest: [String:Int] = [
//            "04-09-2015" : 4,
//            "04-10-2015" : 6,
//            "04-07-2015" : 8,
//            "03-28-2015" : 10,
//            "12-10-2014" : 12,
//            "12-10-2015" : 12]
//
//        //Create a date formatter to convert our date strings to Date objects
//        let df = DateFormatter()
//        df.dateFormat = "MM-dd-yyyy"
//
//        let sortedArrayOfDicts = dayTotalDicTest
//            //First map to an array tuples: [(Date, [String:Int]]
//            .map{(df.date(from: $0.key)!, [$0.key:$0.value])}
//
//            //Now sort by the dates, using `<` since dates are Comparable.
//            .sorted{$0.0 < $1.0}
//
//            //And re-map to discard the Date objects
//            .map{$1}
//
//        for item in sortedArrayOfDicts {
//            print(item)
//        }
        return Task(head: "Vlada", date: "23/11/1997", status: "New Task", text: "DR")
    }
}
