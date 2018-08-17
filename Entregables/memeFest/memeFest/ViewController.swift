//
//  ViewController.swift
//  memeFest
//
//  Created by Servicio Esteban  on 11/08/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var topSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    var images: [UIImage] = [UIImage(named: "cat")!, UIImage(named: "dog")!, UIImage(named: "horse")!]
    
    let topChoices: [[String: String]] = [
        ["🕶": "You know what's cool?"],
        ["💥": "Guess what's lit?"],
        ["💕": "Think of something lovely?"],
        ["💕": "Think of something lovely?"]
    ]
    
    let bottomChoices: [[String: String]] = [
        ["🐱": "A keyboard cat!"],
        ["🐕": "The computer doggo!"],
        ["🐴": "This caring horse!"],
        ["🐴": "This caring horse!"]
    ]
    
    @IBAction func topChoiceChanged(_ sender: UISegmentedControl) {
        let index = topSegmentedControl.selectedSegmentIndex
        topLabel.text = topChoices[index].first?.value
    }
    
    @IBAction func bottomChoiceChanged(_ sender: UISegmentedControl) {
        let index = bottomSegmentedControl.selectedSegmentIndex
        bottomLabel.text = bottomChoices[index].first?.value
        
        if images.count == index {
            images.append(UIImage(named: "excited")!)
        }
        image.image = images[index]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topSegmentedControl.removeAllSegments()
        for choice in topChoices.reversed() {
            topSegmentedControl.insertSegment(withTitle: choice.first?.key , at: 0, animated: false)
        }
        
        bottomSegmentedControl.removeAllSegments()
        for choice in bottomChoices.reversed() {
            bottomSegmentedControl.insertSegment(withTitle: choice.first?.key, at: 0, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}





