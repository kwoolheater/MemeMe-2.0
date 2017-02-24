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
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:.edit, target: self, action: #selector(ShowMemeViewController.editMeme))
        self.image!.image = memeData?.memedImage
    }
    
    func saveExistingMemeChanges()
    {
        
    }
    func editMeme() {
        let storyboard = UIStoryboard (name: "Main", bundle: nil)
        let resultVC = storyboard.instantiateViewController(withIdentifier: "MemeEditorViewController")as! MemeEditorViewController
        // Recreate pieces of original saved image details
        resultVC.memeSentFromDetail = self.memeData
        resultVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveExistingMemeChanges))
        let navController = UINavigationController(rootViewController: resultVC)
        // Communicate the match
        
        present(navController, animated: true, completion: nil)
        
        
    }
    
    
    
    
}
