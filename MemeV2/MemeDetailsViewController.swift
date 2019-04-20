//
//  MemeDetailsViewController.swift
//  MemeV2
//
//  Created by Waiel Eid on 20/4/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit

class MemeDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = meme.memeImage
    }

}
