//
//  ChargesTableViewController.swift
//  HotelManzana
//
//  Created by Daniel Esteban Salinas Suárez on 10/3/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ChargesTableViewController: UITableViewController {

    @IBOutlet weak var numberOfNightsChargeLabel: UILabel!
    @IBOutlet weak var roomTypeChargeLabel: UILabel!
    @IBOutlet weak var wifiChargeLabel: UILabel!
    @IBOutlet weak var totalChargeLabel: UILabel!
    
    var numberOfNightsCharge: Int?
    var roomType: String?
    var roomTypeCharge: Int?
    var hasWifi: String = "No"
    var wifiCharge: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numberOfNightsChargeLabel.text = "\(numberOfNightsCharge!)"
        roomTypeChargeLabel.text = roomType! + "    $ \(roomTypeCharge!)"
        wifiChargeLabel.text = hasWifi + "      $ \(wifiCharge)"
        totalChargeLabel.text = "$ \(roomTypeCharge! + wifiCharge)"
        
    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
