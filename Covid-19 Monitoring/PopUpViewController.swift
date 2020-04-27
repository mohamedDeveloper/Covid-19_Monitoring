//
//  PopUpViewController.swift
//  Covid-19 Monitoring
//
//  Created by mohamed al-ghamdi on 25/04/2020.
//  Copyright © 2020 mohamed al-ghamdi. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var labelsuperView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cabcelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsuperView.roundCorners([.topLeft, .topRight], radius: 10)
        okButton.roundCorners([.bottomRight], radius: 10)
        cabcelButton.roundCorners([.bottomLeft], radius: 10)

    }
    

    @IBAction func okButton(_ sender: Any) {
        self.view.removeFromSuperview()
        popAppear = true
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        self.view.removeFromSuperview()
        popAppear = true
    }
}
extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }

}
