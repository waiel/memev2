//
//  MemeTableViewController.swift
//  MemeV2
//
//  Created by Waiel Eid on 20/4/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    
    var memes: [Meme]{
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memes.count)
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for :indexPath)
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.textLabel?.text = meme.topText + " " + meme.bottomText
        cell.imageView?.image = meme.originalImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}
