//
//  SelectRoomTypeTableViewController.swift
//  HotelManzana
//
//  Created by Daniel Esteban Salinas Suárez on 10/3/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

protocol SelectRoomTypeTableViewControllerDelegate {
    func didSelect(roomType: RoomType)
}

class SelectRoomTypeTableViewController: UITableViewController {

    var roomType: RoomType?
    var delegate: SelectRoomTypeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RoomType.all.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "RoomTypeCell", for: indexPath)
        let roomType = RoomType.all[indexPath.row]
        
        cell.textLabel?.text = roomType.name
        cell.detailTextLabel?.text = "$ \(roomType.price)"
        
        //Select a room
        if roomType == self.roomType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    
    
    
    // MARK: - Additional Table View Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
        indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        roomType = RoomType.all[indexPath.row]
        delegate?.didSelect(roomType: roomType!)
        tableView.reloadData()
    }
    
    


    
}
