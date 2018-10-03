//
//  RegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Daniel Esteban Salinas Suárez on 10/3/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController {

    var registrations: [Registration] = Registration.loadRegistrations() ?? []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        cell.textLabel?.text = "\(registration.firstName) \(registration.lastName)"
        cell.detailTextLabel?.text = dateFormatter.string(from: registration.checkInDate) + " - " + dateFormatter.string(from: registration.checkOutDate) + ": " + registration.roomType.name
        

        return cell
    }

    
    
    
    // MARK: - Aditional Table View Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit
        editingStyle: UITableViewCellEditingStyle, forRowAt indexPath:
        IndexPath) {
        if editingStyle == .delete {
            registrations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Registration.saveRegistrations(registrations)
        }
    }
    
    
    
    // MARK: - Navigation

    @IBAction func unwindFromAddRegistration(unwindSegue:
        UIStoryboardSegue) {
        
        guard
            let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController,
            let registration = addRegistrationTableViewController.registration
        else { return }
        
        registrations.append(registration)
        tableView.reloadData()
        Registration.saveRegistrations(registrations)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "charges" {
            let destinationViewController = segue.destination as?ChargesTableViewController
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let dateInterval = Int(registrations[selectedIndexPath.row].checkOutDate.timeIntervalSince(registrations[selectedIndexPath.row].checkInDate)) / 86400
                let registration = registrations[selectedIndexPath.row]
                
                destinationViewController?.numberOfNightsCharge = dateInterval
                
                destinationViewController?.roomTypeCharge = dateInterval * registration.roomType.price
                
                destinationViewController?.roomType = registration.roomType.shortName
                
                if registration.wifi {
                    destinationViewController?.wifiCharge = 10 * dateInterval
                    destinationViewController?.hasWifi = "Yes"
                } 
            }
        }
    }
    

}
