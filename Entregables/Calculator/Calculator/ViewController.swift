//
//  ViewController.swift
//  Calculator
//
//  Created by Servicio Esteban  on 07/08/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var number: [UIButton]!
    @IBOutlet var op: [UIButton]!
    
    var isFirstMove = true
    let operations = "%*+-/"
    var isResultShowing = false
    
    @IBAction func clearTapped(_ sender: UIButton) {
        resultLabel.text? = "0"
        isResultShowing = false
        isFirstMove = true
    }
    
    @IBAction func dotTapped(_ sender: UIButton) {
        guard canUseDot() else { return }
        
        resultLabel.text?.append(sender.currentTitle!)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if isFirstMove {
            isFirstMove = false
            resultLabel.text?.removeAll()
        }
        if number.contains(sender) {
            writeNumber(sender: sender)
        }

        if op.contains(sender) {
            writeOp(sender: sender)
        }
        


    }
    
    func canUseDot() -> Bool {
        if resultLabel.text?.last == "." || isResultShowing {
            return false
        }
        for operation in operations {
            if (resultLabel.text?.components(separatedBy: String(operation)).contains("."))! {
                return false
            }
        }
        return true
    }
    
    func writeNumber(sender: UIButton) {
        resultLabel.text?.append(sender.currentTitle!)
    }
    
    func writeOp(sender: UIButton) {
        guard !isResultShowing || !(resultLabel.text?.isEmpty)! else {
            return
        }
        guard Int(resultLabel.text!) != nil else {
            return
        }
        
        resultLabel.text?.append(sender.currentTitle!)
    }
    
    @IBAction func calculate(_ sender: UIButton) {
        for operation in operations {
            if (resultLabel.text?.contains(operation))! {
                if let data = resultLabel.text?.components(separatedBy: String(operation)) {
                    
                    print("\(data[0])\(operation)\(data[1])")
                    let expn = NSExpression(format:"\(data[0])\(operation)\(data[1])")
                    resultLabel.text? = "\(expn.expressionValue(with: nil, context: nil) ?? 0)"
                    isResultShowing = true

                }
            }
        }   
    }
    

    @IBAction func exitHelp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

