//
//  personTableViewCell.swift
//  Covid-19 Monitoring
//
//  Created by mohamed al-ghamdi on 25/04/2020.
//  Copyright © 2020 mohamed al-ghamdi. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
let popOver = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PopUpViewController") as PopUpViewController

class personTableViewCell: UITableViewCell {

  
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var homeButton: UIButton!

    @IBOutlet weak var commectsTextView: UITextView!
    @IBOutlet weak var currentLocation: UIButton!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var actionTakeByLabel: UILabel!
    
    @IBOutlet weak var aTime: UILabel!
    @IBOutlet weak var cArea: UILabel!
    
    @IBOutlet weak var aType: UILabel!
    var hLat = 0.0
    var hLan = 0.0
    var cLat = 0.0
    var cLan = 0.0

    @IBAction func homeLocation(_ sender: Any) {
        
        let camera = GMSCameraPosition.camera(withLatitude:hLat, longitude: hLan, zoom: 15.0)
        mapView.camera = camera
    }
    
    @IBAction func currentLocation(_ sender: Any) {
        let camera = GMSCameraPosition.camera(withLatitude:cLat, longitude: cLan, zoom: 15.0)
        mapView.camera = camera
    }
    
    @IBAction func call(_ sender: Any) {
         if let url = URL(string: "telprompt://966591891793") {
               let application = UIApplication.shared
               guard application.canOpenURL(url) else {
                   return
               }
               application.open(url, options: [:], completionHandler: nil)
           }
    }
    
    @IBAction func directions(_ sender: Any) {
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: cLat, longitude: cLan)))
        source.name = "Source"

        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: cLat, longitude: cLan)))
        destination.name = nameLabel.text

        MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    
    @IBAction func close(_ sender: Any) {
        if let viewController = self.getOwningViewController() {
          print(viewController)
            viewController.dismiss(animated: true) {
            }
        }
    }
    @IBAction func exception(_ sender: Any) {
        
        self.superview?.superview?.addSubview(popOver.view)
       // popOver.didMove(toParent: (self.superview. as UIViewController))
    }
    
}
extension UIResponder {
  
  func getOwningViewController() -> UIViewController? {
    var nextResponser = self
    while let next = nextResponser.next {
      nextResponser = next
      if let viewController = nextResponser as? UIViewController {
        return viewController
      }
    }
    return nil
  }
}
