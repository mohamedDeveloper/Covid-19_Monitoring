//
//  InvestigateViewController.swift
//  Covid-19 Monitoring
//
//  Created by mohamed al-ghamdi on 24/04/2020.
//  Copyright © 2020 mohamed al-ghamdi. All rights reserved.
//

import UIKit

import GoogleMaps
//AIzaSyDsqwkmIUcOBfORCDGS4cSY4F8wvjWsQMk
    var mapView : GMSMapView!
var popAppear = false

class InvestigateViewController: UIViewController {
    struct person{
        var name = ""
        var phone = ""
        var hLang = 0.0
        var hLat = 0.0
        var cLang = 0.0
        var cLat = 0.0
    }
    @IBOutlet weak var cArea: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var aTime: UILabel!
    
    @IBOutlet weak var aType: UILabel!
    
    var caseNumber = 0
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cordinateView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyDsqwkmIUcOBfORCDGS4cSY4F8wvjWsQMk")
        let camera = GMSCameraPosition.camera(withLatitude:0.0, longitude: 0.0, zoom: 14.0)

        mapView = GMSMapView.map(withFrame: self.cordinateView.frame, camera: camera)
        self.view.addSubview(mapView)

        if caseNumber == 0 || caseNumber == 2 {
            case0()
        }else{
            case1()
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")

        view.addGestureRecognizer(tap)
        
        self.addChild(popOver)
        popOver.view.frame = self.view.frame
    }
    override func viewDidLayoutSubviews() {
        if popAppear {
            popAppear = false
            dismiss(animated: true) {
            }
        }
    }
    
 
    @objc func dismissKeyboard() {

        view.endEditing(true)
    }
    func getPersons()->[person]{
        var persons = [person]()
        persons.append(.init(name: "Mohamed Alghamdi", phone: "+96651111111", hLang: 50.0717783, hLat: 26.453606, cLang: 50.0676365, cLat: 26.458889))
        persons.append(.init(name: "Omar Khalid", phone: "+96651111112", hLang: 50.0678623, hLat: 26.4526454,  cLang: 50.0676365, cLat: 26.458889))
        persons.append(.init(name: "Khalid Mohamed", phone: "+96651111113", hLang: 50.0694394, hLat: 26.4548355,  cLang: 50.0676365, cLat: 26.458889))
        persons.append(.init(name: "Ahmed Ali", phone: "+96651111114", hLang: 50.0691493, hLat: 26.456286, cLang: 50.0676365, cLat: 26.458889))
        return persons
    }
    func case0(){
        mapView.clear()
        let persons = getPersons()
        let camera = GMSCameraPosition.camera(withLatitude:persons[0].cLat, longitude: persons[0].cLang, zoom: 14.0)
        mapView.camera = camera
        for pers in persons {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: pers.hLat, longitude: pers.hLang)
            marker.title = pers.name
            marker.snippet = "Home"
            marker.map = mapView
        }
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: persons[0].cLat, longitude: persons[0].cLang)
        marker.title = "4 people Gathered"
       // marker.snippet = "Home"
        marker.map = mapView
        if caseNumber == 2 {
            cArea.text = "violation, warning has been given"
            aTime.text = "5:07 PM"
            aType.text = "Close"
            nameLabel.text = "Mohamed"
        }
    }
    func case1(){
         mapView.clear()
        let persons = getPersons()
        let camera = GMSCameraPosition.camera(withLatitude:persons[0].cLat, longitude: persons[0].cLang, zoom: 14.0)
        mapView.camera = camera

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: persons[1].hLat, longitude: persons[1].hLang)
        marker.title = persons[0].name
        marker.snippet = "Home"
        marker.map = mapView
        
        let markerq = GMSMarker()
        markerq.position = CLLocationCoordinate2D(latitude: persons[0].cLat, longitude: persons[0].cLang)
        markerq.title = "moved 350 meters out of his home"
              // marker.snippet = "Home"
        markerq.map = mapView
        if caseNumber == 3 {
            cArea.text = "A delivery guy with legal statement"
            aTime.text = "4:25 PM"
            aType.text = "Exception"
            nameLabel.text = "Omar"
        }
    }

}
extension InvestigateViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if caseNumber == 0 {
            return getPersons().count + 2
            
        }else if caseNumber == 2 {
            return getPersons().count 
        }else if caseNumber == 3 {
            return 1
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! personTableViewCell
//        if caseNumber == 3 || caseNumber == 2 {
//            cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! personTableViewCell
//
//        }
        if indexPath.row < getPersons().count && (caseNumber == 0 || caseNumber == 2){
        
            cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! personTableViewCell
        cell.nameLabel.text = getPersons()[indexPath.row].name
        cell.phoneNumberLabel.text = getPersons()[indexPath.row].phone
        cell.hLat = getPersons()[indexPath.row].hLat
        cell.hLan = getPersons()[indexPath.row].hLang
        cell.cLan = getPersons()[indexPath.row].cLang
            cell.cLat = getPersons()[indexPath.row].cLat
            
        }else if indexPath.row == 0 && (caseNumber == 1 || caseNumber == 3) {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! personTableViewCell
            cell.nameLabel.text = getPersons()[indexPath.row].name
            cell.phoneNumberLabel.text = getPersons()[indexPath.row].phone
            cell.hLat = getPersons()[indexPath.row+1].hLat
            cell.hLan = getPersons()[indexPath.row+1].hLang
            cell.cLan = getPersons()[indexPath.row].cLang
            cell.cLat = getPersons()[indexPath.row].cLat
        }else if (indexPath.row == getPersons().count || indexPath.row == 1) && caseNumber != 3 && caseNumber != 2  {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! personTableViewCell
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(section)
        
        return 0.001
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("yes")
    }
}
