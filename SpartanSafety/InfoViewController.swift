//
//  InfoViewController.swift
//  SpartanSafety
//
//  Created by Austin Evans on 11/27/17.
//  Copyright © 2017 Austin Evans. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController{
    @IBAction func icons8(_ sender: Any) {
        let url = URL(string: "https://icons8.com")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}
