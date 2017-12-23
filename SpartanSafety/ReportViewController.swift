//
//  ReportViewController.swift
//  SpartanSafety
//
//  Created by Austin Evans on 10/31/17.
//  Copyright © 2017 EGR 100 - Section 22 - Group 4. All rights reserved.
//

import UIKit
import MessageUI
import MapKit
import GooglePlaces

class ReportViewController: UIViewController, MFMessageComposeViewControllerDelegate, CLLocationManagerDelegate, UITabBarDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var updateCurrentLocationButton: UIButton!
    @IBOutlet weak var situationTextField: UITextField!
    
    var longAndLatLabel: String?
    
    let phoneNumberMSUPD = "517-355-2221" // real number: 517-355-2221
    let textNumberMSUPD = "274637" // real number: 274637
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        // Dismiss message view controller
        controller.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        // Ask for location authoization
        self.locationManager.requestWhenInUseAuthorization()
        
        placesClient = GMSPlacesClient.shared()
        
        getCurrentLocation(updateCurrentLocationButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.situationTextField.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        manager.stopUpdatingLocation()
        let coordinates = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        // round longitude and latitude to .0001th place
        let roundedLat = String(round(userLocation.coordinate.latitude*10000)/10000)
        let roundedLong = String(round(userLocation.coordinate.longitude*10000)/10000)
        longAndLatLabel = "(\(roundedLat), \(roundedLong))"
        
        // let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMakeWithDistance(coordinates, 1609.344, 1609.344)
        
        // plot location on map
        mapView.setRegion(region, animated: true)
    }
    
    // return String with only numbers 1 through 9
    func removeNonNumeric (str: String) -> String {
        return String(str.filter { "01234567890.".contains($0) })
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
    
    @IBAction func callButton(_ sender: Any) {
        let phoneNumber: String = removeNonNumeric(str: phoneNumberMSUPD)
        
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            failureAlert(message: "Unable to connect to cellular services")
        }
    }
    
    @IBAction func textButton(_ sender: Any) {
        getCurrentPlace()
        if MFMessageComposeViewController.canSendText() {
            var body:String
            if let placeName = nameLabel.text, let placeLocation = addressLabel.text, let longlat = longAndLatLabel {
                body = "SpartanSafety generated alert from \(placeName) at address: \n\(placeLocation)\n\(longlat)\n"
            } else {
                body = "SpartanSafety generated alert from an unknown location.\n\n"
            }
            
            if let situation = situationTextField.text {
                body += "Situation Description: \(situation)"
            }
            
            let message = MFMessageComposeViewController()
            
            message.body = body
            message.recipients = [textNumberMSUPD]
            message.messageComposeDelegate = self
            
            self.present(message, animated: true)
            
        } else {
            failureAlert(message: "Unable to connect to SMS services")
        }
    }
    
    @IBAction func getCurrentLocation(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        getCurrentPlace()
    }
    
    func getCurrentPlace() {
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
            if let error = error {
                print("Pick Place error: \(error.localizedDescription)")
                return
            }
            
            if let placeLikelihoodList = placeLikelihoodList {
                let place = placeLikelihoodList.likelihoods.first?.place
                if let place = place {
                    self.nameLabel.text = place.name
                    self.addressLabel.text = place.formattedAddress?.components(separatedBy: ", ").joined(separator: ", ")
                }
            }
        })
    }
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        situationTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        situationTextField.resignFirstResponder()
        return true
    }
}


