//
//  ViewController.swift
//  SystemViewControllers
//
//  Created by Servicio Esteban  on 25/09/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        guard let image = imageView.image else { return }
        let activityController =
            UIActivityViewController(activityItems: [image],
                                     applicationActivities: nil)
        //popover es para que en ipad se muetre donde presionaste
        activityController.popoverPresentationController?.sourceView = sender
        
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func safariButtonTapped(_ sender: UIButton) {
        if let url = URL(string: "http://www.apple.com") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                print("User selected Camera action")
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
                })
                alertController.addAction(cameraAction)
        } else {
            print("No camera available.")
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                print("User selected Photo Library action")
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
                })
                alertController.addAction(photoLibraryAction)
        } else {
            print("No Photo Library available.")
        }
        
        
        alertController.popoverPresentationController?.sourceView =
        sender
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedImage =
            info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self

        mailComposer.setToRecipients(["example@example.com"])
        mailComposer.setSubject("Look at this")
        mailComposer.setMessageBody("Hello, this is an email from the app I made.", isHTML: false)
        
        present(mailComposer, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func textButtonTapped(_ sender: Any) {
        guard MFMessageComposeViewController.canSendText() else {
            print("SMS Services are not available.")
            return
        }
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.recipients = ["4085551212"]
        composeVC.body = "Hello from Mexico!"
        
        // Present the view controller modally.
        present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

