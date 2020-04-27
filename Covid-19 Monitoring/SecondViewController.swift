//
//  SecondViewController.swift
//  Covid-19 Monitoring
//
//  Created by mohamed al-ghamdi on 23/04/2020.
//  Copyright © 2020 mohamed al-ghamdi. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    struct incedint{
            var title = ""
            var time = ""
            var details = ""
            var actionTakenBy = ""
        }
        @IBOutlet weak var incedintsTableView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            incedintsTableView.rowHeight = UITableView.automaticDimension
            incedintsTableView.estimatedRowHeight = 600

        }
        var caseNumber = 0
        func getIncedint()->[incedint]  {
            var incedints = [incedint]()
            incedints.append(.init(title: "Moving", time: "(3:45 PM - 3:57 PM)", details: "Moved 350 meters out of his home",actionTakenBy:"Excepted by Omar"))
            incedints.append(.init(title: "Gathering", time: "(12:45 pm - 11:00 PM)", details: "4 People detected with unusual gathering",actionTakenBy:"Closed by Mohamed"))
            incedints.append(.init(title: "Gathering", time: "(3:32 PM - )", details: "9 People detected with unusual gathering",actionTakenBy:"Closed by Mohamed"))
            incedints.append(.init(title: "Moving", time: "(2:45 PM - 2:50 PM)", details: "Moved 900 meters out of his home",actionTakenBy:"Excepted by Mohamed"))
    //        incedints.append(.init(title: "", time: "", details: ""))
    //        incedints.append(.init(title: "", time: "", details: ""))
    //        incedints.append(.init(title: "", time: "", details: ""))

            return incedints
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is InvestigateViewController
               {
                   let vc = segue.destination as? InvestigateViewController
                    vc?.caseNumber = caseNumber
               }
        }
    }

    extension SecondViewController: UITableViewDelegate,UITableViewDataSource {

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return getIncedint().count
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 || indexPath.row == 1 {
                if indexPath.row == 0{
                    caseNumber = 3
                }else {
                    caseNumber = 2
                }
                self.performSegue(withIdentifier: "invetigate2", sender: self)
                
            }
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! IncidentTableViewCell
            cell.titleLabel.text = getIncedint()[indexPath.row].title
            cell.timeLabel.text = getIncedint()[indexPath.row].time
            cell.detailsLabel.text = getIncedint()[indexPath.row].details
            cell.actionTakenByLabel.text = getIncedint()[indexPath.row].actionTakenBy

            return cell
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            print(section)
            
            return 0.001
        }
    }

