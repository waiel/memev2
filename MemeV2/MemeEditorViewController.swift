//
//  MemeEditorViewController.swift
//  MemeV2
//
//  Created by Waiel Eid on 1/4/19.
//  Copyright © 2019 Waiel Eid. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    
    //MARK: variables declaration requried
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth: -2.0
    ]
    
    //MARK: IBOutlet definitions
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    
    //MARK: activity functions
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        resetState()
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    //reset applicaiton to default state
    func resetState(){
        imagePickerView.image = nil
        imagePickerView.backgroundColor = UIColor.black
        shareButton.isEnabled = false
        setupTextField(topTextField, text: "TOP")
        setupTextField(bottomTextField, text: "BOTTOM")
    }
    
    //MARK: Keyboard functions
    
    // When showing lifts screen up
    @objc func keyboardWillShow(_ notification: Notification) {
        //reaise keyboard for lower text only
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    // When hiding return to original state
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    //get the keyboard layout height
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    //setup keyboard notification
    func subscribeToKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //remove keyboard notificaiton
    func unsubscribeFromKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Meme image
    
    //save meme image
    func saveMeme() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!,memeImage:  self.generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    //generate meme image
    func generateMemedImage() -> UIImage {
        //hide toolbars
        self.topToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        // Show toolbar
        self.topToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
        return memeImage
    }
    
    
    //MARK: IBActions
    
    //pick image from camera
    @IBAction func openCamera(_ sender: Any) {
        presentPickerViewController(source: .camera)
    
    }
    
    //pick image from album
    @IBAction func pickAnImage(_ sender: Any) {
        presentPickerViewController(source: .photoLibrary)
    }
    
    //open share activity
    @IBAction func openShare(_ sender: Any) {
        let image = generateMemedImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        //add a check if activity contoller dismissed and save image if action completed
        controller.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            //save if action complete and there was no error
            
            if completed && error == nil {
                self.saveMeme()
            }
        }
        present(controller,animated: true,completion: nil)
    }
    
    //cancel and reset app
    @IBAction func cancelMeme(_ sender: Any) {
        resetState()
        dismiss(animated: true, completion: nil)
    }
}

//MARK: UIImagePickerControllerDelegate extention

extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPickerViewController(source: UIImagePickerController.SourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // handel image selection from album
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            //enable share button
            shareButton.isEnabled = true
        }
        //close the image picker
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: UITextFieldDelegate extention
extension MemeEditorViewController: UITextFieldDelegate {

   //setup textField
    func setupTextField(_ textField: UITextField, text: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.text = text
    }
    
    //reset field if editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    //hide keyboard when return pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bottomTextField.resignFirstResponder()
        topTextField.resignFirstResponder()
        return true
    }
}
