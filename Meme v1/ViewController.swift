//
//  ViewController.swift
//  Meme v1
//
//  Created by Waiel Eid on 1/4/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func openCamera(_ sender: Any) {
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        present(pickerController, animated: true, completion: nil)
    }
}

