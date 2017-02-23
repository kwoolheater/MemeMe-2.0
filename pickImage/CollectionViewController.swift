//
//  CollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Kiyoshi Woolheater on 2/21/17.
//  Copyright © 2017 Kiyoshi Woolheater. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        guard flowLayout != nil else {
            return
        }
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memeData: [Meme] {
        return appDelegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memeData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let memeForRow = self.memeData[indexPath.row]
        cell.memeImage?.image = memeForRow.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "ShowMemeViewController") as! ShowMemeViewController
        
        //populate the data
        let memeForRow = self.memeData[indexPath.row]
        detailController.memeData = memeForRow
        
        //push controller
        navigationController!.pushViewController(detailController, animated: true)
    }
    
}
