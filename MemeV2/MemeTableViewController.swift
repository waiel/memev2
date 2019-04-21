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
    
    //Get the memes
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //reload data in table
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //reload data in table
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of memes in the array
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for :indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.row]
        
        // Set the name and image
        cell.MemeImage.image = meme.memeImage
        cell.MemeText.text = meme.topText  + "\n" + meme.bottomText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //set the detail view screen
        let Detailview = self.storyboard?.instantiateViewController(withIdentifier: "MemeDtetailView") as! MemeDetailsViewController
        //hide the Tab bar
        Detailview.hidesBottomBarWhenPushed = true;
        //set the selected meme
        let meme = memes[indexPath.row]
        Detailview.meme = meme
        //show the detail view screen
        self.navigationController?.pushViewController(Detailview, animated: true)
        
    }
    
    
}
