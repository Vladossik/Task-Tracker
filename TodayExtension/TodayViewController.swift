//
//  TodayViewController.swift
//  TodayExtension
//
//  Created by Vladislava on 23/06/2019.
//  Copyright © 2019 VladislavaVakulenko. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
   
    @IBOutlet weak var headTask: UILabel!
    @IBOutlet weak var statusTask: UILabel!
    @IBOutlet weak var dateTask: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = UserDefaults(suiteName: "group.sharingForTodayExtension")
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
