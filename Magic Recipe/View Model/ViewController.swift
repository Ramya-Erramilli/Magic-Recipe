//
//  ViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,GetRecipesDelegate {

    
    @IBOutlet weak var firstTextField: UITextField!
    
    static var recipesList:[Recipe] = []
    var ingredients=""
    var prevRect:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.        
        
//        cm.delegate = self
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
    
//    var cm = ConnectionManager()
    @IBAction func getRecipesAction(_ sender: UIButton) {
        
    }
    
    func didGetRecipes(recipes: [Recipe]) {
//        ViewController.recipesList = recipes
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var dest = segue.destination as! ListTableViewController
        dest.ingredients = self.ingredients
        dest.reloadInputViews()
    }


    func addNewTextField(){
        let newTextField =  UITextField(frame: CGRect(x: prevRect!.minX, y: prevRect!.minY+prevRect!.height+10.0, width: prevRect!.width, height: prevRect!.height))
        newTextField.placeholder = "Enter text here"
        newTextField.font = UIFont.systemFont(ofSize: 15)
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.autocorrectionType = UITextAutocorrectionType.no
        newTextField.becomeFirstResponder()
        newTextField.returnKeyType = UIReturnKeyType.default
        newTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        newTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        newTextField.autocapitalizationType = .none
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
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}
