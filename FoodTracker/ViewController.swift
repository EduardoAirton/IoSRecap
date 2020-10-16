//
//  ViewController.swift
//  FoodTracker
//
//  Created by Luan Cabral on 20/03/20.
//  Copyright © 2020 Luan Cabral. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK:Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var mealNameLabel: UILabel!
    @IBOutlet weak var mealImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.mealNameLabel.text = textField.text 
    }
    
    //MARK:PickerController Delegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{
            fatalError("Expect the original but recive \(info)")
        }
        
        self.mealImage.image = selectedImage
        dismiss(animated: false, completion: nil)
        
    }
    
    
    //MARK: Actions
    @IBAction func selectImageLibrary(_ sender: UITapGestureRecognizer) {
        //Hide the keyboard
        nameTextField.resignFirstResponder()
        
        //Create a picker controller whose into in the photoLibrary
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        
        //Notify the view controller when use pickerController
        imagePicker.delegate = self
        present(imagePicker, animated: false, completion: nil)
        
    }
    @IBAction func setDefaultLabelText(_ sender: Any) {
        self.mealNameLabel.text = "Botão inicial"
    }
    
    
    
}

