//
//  ViewController.swift
//  pickImage
//
//  Created by Kiyoshi Woolheater on 12/18/16.
//  Copyright © 2016 Kiyoshi Woolheater. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    var currentTextField:String = ""
    
    let memeTextAttributes: [String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0
    ]
    
    func configureTextFields(textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields(textField: topTextField)
        configureTextFields(textField: bottomTextField)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(MemeEditorViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareButton.isEnabled = (imagePickerView.image != nil)
        if (bottomTextField.text == "BOTTOM") {
            subscribeToKeyboardNotifications()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotification()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField.text == "TOP" || textField.text == "BOTTOM") {
            textField.text = ""
        }
        
        if textField == topTextField {
            currentTextField = "top"
        } else if textField == bottomTextField {
            currentTextField = "bottom"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (topTextField.text == "") {
            topTextField.text = "TOP"
        }
        
        if (bottomTextField.text == "") {
            bottomTextField.text = "BOTTOM"
        }
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func pickAnImageFromSource(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch sender {
            case albumButton: imagePicker.sourceType = .photoLibrary
            case cameraButton: imagePicker.sourceType = .camera
            default: ()
        }
        present(imagePicker, animated: true, completion: nil)
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info [UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        // raises keyboard if bottom text field is selected
        if currentTextField == "bottom" {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func dismissKeyboard (){
        view.endEditing(true)
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    @IBAction func share(_ sender: Any) {
        //Create a memed image, pass it to the activity view controller.
        let meme = generateMemedImage()
        self.saveMeme()
        let activityVC = UIActivityViewController(activityItems: [meme],
                                                  applicationActivities: nil)

        activityVC.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.dismiss(animated: true, completion: nil)
                self.performSegue(withIdentifier: "tabBarSegue", sender: self)
            }
        }
        
        self.present(activityVC, animated: true, completion: nil)
        
        
        
    }
    
    func saveMeme() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage:generateMemedImage())
        
        // Add to AppDelegate array
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    func generateMemedImage() -> UIImage {
        
        // TODO: Hide toolbar and navbar
        self.navigationController?.isNavigationBarHidden = true
        self.bottomToolbar?.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        self.navigationController?.isNavigationBarHidden = false
        self.bottomToolbar?.isHidden = false
        
        return memedImage
    }
    
    @IBAction func cancel(_ sender: Any) {
        //clear image and reset text fields
        imagePickerView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        //redisable share button
        shareButton.isEnabled = (imagePickerView.image != nil)
    }
}

