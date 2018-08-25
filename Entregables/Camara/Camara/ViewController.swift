//
//  ViewController.swift
//  Camara
//
//  Created by Servicio Esteban  on 25/08/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var Photo: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }



    @IBAction func takePhoto(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        //le delego su comportamiento a self(que es el view controller)
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Cámara disponible")
        } else {
            print("Ahora no hay cámara")
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            Photo.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
}

