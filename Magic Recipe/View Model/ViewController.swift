//
//  ViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var firstTextField: UITextField!
    
    var ingredients=""
    var prevRect:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        
        
        firstTextField.delegate = self
        firstTextField.endEditing(true)
        prevRect = firstTextField.frame
    }
 
//    override func viewDidAppear(_ animated: Bool) {
//        print(ConnectionManager().fetchData())
//    }
    @IBAction func addTextField(_ sender: UIButton) {
        //    print("here")
        
        addNewTextField()
        
        let newFrame = [sender.frame.minX,sender.frame.minY+prevRect!.height+10.0,sender.frame.width,sender.frame.height]
        sender.frame = CGRect(x: newFrame[0], y:newFrame[1] , width: newFrame[2], height: newFrame[3])
        
    }
    
    
    @IBAction func getRecipesAction(_ sender: UIButton) {
        ConnectionManager().fetchData(ingredients: ingredients)
        
    }
    
    
    
    func addNewTextField(){
        let newTextField =  UITextField(frame: CGRect(x: prevRect!.minX, y: prevRect!.minY+prevRect!.height+10.0, width: prevRect!.width, height: prevRect!.height))
        newTextField.placeholder = "Enter text here"
        newTextField.font = UIFont.systemFont(ofSize: 15)
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.autocorrectionType = UITextAutocorrectionType.no
        newTextField.keyboardType = UIKeyboardType.default
        newTextField.returnKeyType = UIReturnKeyType.done
        newTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        newTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        newTextField.delegate = self
        self.view.addSubview(newTextField)
        prevRect = newTextField.frame
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var ing = textField.text{
            ing = ing.trimmingCharacters(in: .whitespaces)
            if self.ingredients == ""{
                self.ingredients += ing
            }else{
                self.ingredients += ",\(ing)"
            }
        }
        ingredients = ingredients.trimmingCharacters(in: .whitespaces)
//        print(ingredients)
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
   
    
}

