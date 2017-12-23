//
//  Resources.swift
//  SpartanSafety
//
//  Created by Austin Evans on 11/3/17.
//  Copyright © 2017 EGR 100 - Section 22 - Group 4. All rights reserved.
//

import UIKit

class Resources: NSObject {
    var title: String
    var subtitle: String?
    var phoneNumber: String
    var initalText: String?
    
    init(title: String, subtitle: String? = nil, phoneNumber: String, initalText:String? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.phoneNumber = removeDashes(formattedNumber: phoneNumber)
        self.initalText = initalText
        
        super.init()
    }
}

func removeDashes(formattedNumber: String) -> String {
    return formattedNumber.replacingOccurrences(of: "-", with: "")
}
