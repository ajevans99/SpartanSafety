//
//  ResourceCollection.swift
//  SpartanSafety
//
//  Created by Austin Evans on 11/3/17.
//  Copyright © 2017 EGR 100 - Section 22 - Group 4. All rights reserved.
//

import UIKit

class ResourceCollection {
    var allResources = [Resources]()
    
    init() {
        // Add Resources here
        allResources.append(Resources(title: "Alcohol, Tobacco, & Other Drugs", subtitle: "Collegiate Recovery Program", phoneNumber: "517-884-6598"))
        allResources.append(Resources(title: "Counseling Center", subtitle: "Appointment", phoneNumber: "517-355-8270"))
        allResources.append(Resources(title: "Crisis Text Line", subtitle: "Get Help Now: Free, 27/7, Confidential", phoneNumber: "741-741", initalText: "START"))
        allResources.append(Resources(title: "HIV Counseling & Testing", subtitle: "Appointment", phoneNumber: "517-353-4660"))
        allResources.append(Resources(title: "Medical Emergency", subtitle: "Call 911", phoneNumber: "911"))
        allResources.append(Resources(title: "Medical & Wellness Visits", subtitle: "Appointment", phoneNumber: "517-353-4660"))
        allResources.append(Resources(title: "Nutrition Counseling", subtitle: "Appointment", phoneNumber: "517-353-4660"))
        allResources.append(Resources(title: "Olin Phone Information Nurse", subtitle: "24 Hour Service", phoneNumber: "517-353-5557"))
        allResources.append(Resources(title: "Sexual Assault Hotline", subtitle: "24 Hour Crisis Line", phoneNumber: "517-372-6666"))
        allResources.append(Resources(title: "STI Counseling & Testing", subtitle: "Appointment", phoneNumber: "517-353-4660"))
        allResources.append(Resources(title: "Suicide Prevention Hotline", subtitle: "24 Hour Service", phoneNumber: "1-800-273-8255"))
    }
}
