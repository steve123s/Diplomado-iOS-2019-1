//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Servicio Esteban  on 21/09/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    
    var emojis: [Emoji] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let loadedEmojis = Emoji.loadFromFile() {
            emojis = loadedEmojis
        } else {
            emojis = Emoji.loadSampleEmojis()
        }
        //navigationItem.leftBarButtonItem = editButtonItem
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBActions
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }

    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return emojis.count
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell

        // Configure the cell...
        
        //Fetch an emoji
        let emoji = emojis[indexPath.row]
        
        //update cell with emoji
        cell.update(with: emoji)
        
        cell.showsReorderControl = true //Shows reorder lines
        return cell
    }
    
    
    // MARK: - Table editing

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        Emoji.saveToFile(emojis: emojis)
    }
    

    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
    }
 

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let destination = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = destination.topViewController
                as! AddEditEmojiTableViewController
            addEditEmojiTableViewController.emoji = emoji
        }
    }

    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue ) {
        
        guard segue.identifier == "saveUnwind" else { return }
       
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: emojis.count,
                                             section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        Emoji.saveToFile(emojis: emojis)
    }
}
