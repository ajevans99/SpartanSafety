//
//  ResourcesViewController.swift
//  SpartanSafety
//
//  Created by Austin Evans on 11/1/17.
//  Copyright © 2017 EGR 100 - Section 22 - Group 4. All rights reserved.
//

import UIKit
import MessageUI

class ResourcesViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    var resourcesCollection: ResourceCollection!
    var fontColors = [UIColor(red:0.27, green:0.12, blue:0.20, alpha:1.0), // Purple-ish
                      UIColor(red:0.16, green:0.28, blue:0.29, alpha:1.0), // Blue-ish
                      UIColor(red:0.69, green:0.36, blue:0.21, alpha:1.0), // Orange-ish
                      UIColor(red:0.17, green:0.36, blue:0.20, alpha:1.0), // Green-ish
                      UIColor(red:0.42, green:0.15, blue:0.10, alpha:1.0)] // Red-ish
    var fontIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resourcesCollection = ResourceCollection()
        
        tableView.alwaysBounceVertical = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourcesCollection.allResources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "UITableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        let resource = resourcesCollection.allResources[indexPath.row]
        
        cell.textLabel?.text = resource.title
        cell.textLabel?.textColor = fontColors[fontIndex]
        if fontIndex == fontColors.count - 1 {
            fontIndex = 0
        } else {
            fontIndex += 1
        }
        cell.detailTextLabel?.text = resource.subtitle
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resource = resourcesCollection.allResources[indexPath.row]
        if let text = resource.initalText {
            if MFMessageComposeViewController.canSendText() {
                let message = MFMessageComposeViewController()
                
                message.body = text
                message.recipients = [resource.phoneNumber]
                message.messageComposeDelegate = self
                
                self.present(message, animated: true)
            } else {
                failureAlert(message: "Unable to connect to SMS services")
            }
        } else {
            if let url = URL(string: "tel://\(resource.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                failureAlert(message: "Unable to connect to cellular services")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Dismiss message view controller
        controller.dismiss(animated: true, completion: nil)
    }
    
    func failureAlert (message: String) {
        let alertController = UIAlertController(title: "Critical Alert", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default) {
            UIAlertAction in
            print("Dismiss pressed")
        }
        alertController.addAction(dismissAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
