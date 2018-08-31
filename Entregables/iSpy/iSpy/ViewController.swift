//
//  ViewController.swift
//  iSpy
//
//  Created by Servicio Esteban  on 30/08/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scroll.delegate = self
        
        updateZoomFor(size: view.bounds.size)
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }

    func updateZoomFor(size: CGSize) {
        let widthScale = size.width / image.bounds.width
        let heightScale = size.height / image.bounds.height
        let scale = min(widthScale, heightScale)
        scroll.minimumZoomScale = scale
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

