//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Kiyoshi Woolheater on 2/16/17.
//  Copyright © 2017 Kiyoshi Woolheater. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var _tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memeData: [Meme] {
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of rows in table view
        return self.memeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        
        let memeForRow = self.memeData[indexPath.row]
        cell.textLabel?.text = "\(memeForRow.topText)...\(memeForRow.bottomText)"
        cell.imageView?.image = memeForRow.memedImage
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get the view controller from storybord
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "ShowMemeViewController") as! ShowMemeViewController
        
        //populate the data
        let memeForRow = self.memeData[indexPath.row]
        detailController.meme = memeForRow
        
        //push controller
        navigationController!.pushViewController(detailController, animated: true)
    }
}
