//
//  ViewController.swift
//  Meme v1
//
//  Created by Waiel Eid on 1/4/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func openCamera(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    
    }
    
    // handel image selection from album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
        }
        //close the image picker 
         self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func openShare(_ sender: Any) {
                let image = UIImage()
                let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                present(controller,animated: true,completion: nil)
    }
    
}

