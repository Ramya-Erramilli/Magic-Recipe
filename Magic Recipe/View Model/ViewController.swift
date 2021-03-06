//
//  ViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 22/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var innerView: UIScrollView!
    
    
    var recipesList:[Recipe] = []
    var ingredients=""
    var prevRect:CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        innerView.showsVerticalScrollIndicator = true
        innerView.showsHorizontalScrollIndicator = true
        firstTextField.delegate = self
        firstTextField.endEditing(true)
        prevRect = firstTextField.frame
        
        let alert = CustomAlert.createAlert(title: "Welcome to Magic Recipe!", descr: """
            
Get recipes based on ingredients available to you.

Press Return/Enter once you have added all the ingredients.
""")
        self.present(alert, animated: true)

    }

    @IBAction func addTextField(_ sender: UIButton) {
        addNewTextField()
        let newFrame = [sender.frame.minX,sender.frame.minY+prevRect!.height+10.0,sender.frame.width,sender.frame.height]
        sender.frame = CGRect(x: newFrame[0], y:newFrame[1] , width: newFrame[2], height: newFrame[3])
    }

    @IBAction func getRecipesAction(_ sender: UIButton) {
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? RecipesViewController
        dest!.ing = self.ingredients
    }
    
    func addNewTextField(){
        
        let newTextField =  UITextField(frame: CGRect(x: prevRect!.minX, y: prevRect!.minY+prevRect!.height+10.0, width: prevRect!.width, height: prevRect!.height))
        newTextField.placeholder = "Enter ingredient name here"
        newTextField.font = UIFont.systemFont(ofSize: 15)
        newTextField.borderStyle = UITextField.BorderStyle.roundedRect
        newTextField.autocorrectionType = UITextAutocorrectionType.no
        newTextField.becomeFirstResponder()
        newTextField.returnKeyType = UIReturnKeyType.done        
        newTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        newTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        newTextField.autocapitalizationType = .none
        newTextField.delegate = self
        innerView.addSubview(newTextField)
        prevRect = newTextField.frame
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if var ing = textField.text{
            ing = ing.trimmingCharacters(in: .whitespaces)
            if self.ingredients == "" || ing == " "{
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

