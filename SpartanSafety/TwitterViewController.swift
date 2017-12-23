//
//  TwitterViewController.swift
//  SpartanSafety
//
//  Created by Austin Evans on 10/31/17.
//  Copyright © 2017 EGR 100 - Section 22 - Group 4. All rights reserved.
//

import UIKit
import TwitterKit

class TwitterViewController: TWTRTimelineViewController {
    var screenName: String?
    @IBOutlet weak var switchBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // default
        screenName = "msupolice"
        updateTweets()
    }
    func updateTweets() {
        self.dataSource = TWTRUserTimelineDataSource(screenName: screenName!, apiClient: TWTRAPIClient())
    }
    @IBAction func switchScreenName(_ sender: Any) {
        if screenName == "EastLansingPD" {
            screenName = "msupolice"
            switchBarButton.title = "ELPD"
        } else if screenName == "msupolice" {
            screenName = "EastLansingPD"
            switchBarButton.title = "MSUPD"
        }
        updateTweets()
    }
    
}
