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
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.image!.image = meme.memedImage
    }
    
    @IBAction func editButton(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        //populate the data
        detailController.imagePickerView!.image = meme?.originalImage
        detailController.topTextField!.text = meme?.topText
        detailController.bottomTextField!.text = meme?.bottomText
        
        //push controller
        
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
}
