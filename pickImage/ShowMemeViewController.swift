//
//  ShowMemeViewController.swift
//  MemeMe 2.0
//
//  Created by Kiyoshi Woolheater on 2/16/17.
//  Copyright © 2017 Kiyoshi Woolheater. All rights reserved.
//

import UIKit

class ShowMemeViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    var memeData: Meme?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Sent Memes", style:.plain, target:nil, action:nil)
        self.image!.image = memeData?.memedImage
    }
    
    @IBAction func editButton(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        //populate the data
        detailController.imagePickerView!.image = memeData?.originalImage
        detailController.topTextField!.text = memeData?.topText
        detailController.bottomTextField!.text = memeData?.bottomText
        
        //push controller
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditor" {
            
        }
    }
    
    
}
