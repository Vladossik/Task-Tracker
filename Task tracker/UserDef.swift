//
//  File.swift
//  Tasktracker
//
//  Created by Vladislava on 18/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import Foundation

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
var allKeys = UserDefaults.standard.stringArray(forKey: "all-keys") ?? []

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
    
    func getKey(with task: Task) -> String {
        var keyTask: String = ""
        for i in allKeys {
            if task == userDefaults.getTask(with: i) {
                keyTask = i
            }
        }
        return keyTask
    }
    
    func remove(with key: String) {
        userDefaults.removeObject(forKey: key)
        if let index = allKeys.firstIndex(of: key) {
            allKeys.remove(at: index)
        }
        userDefaults.set(allKeys, forKey: "all-keys")
        
        userDefaults.synchronize()
    }
}
