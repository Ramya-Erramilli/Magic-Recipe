//
//  CustomAlert.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 23/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import Foundation
import UIKit
//Class to create Custom Alert

class CustomAlert{
    
    static func createAlert(title:String,descr:String)-> UIAlertController{
        
        let alert = UIAlertController(title: title, message: """

            \(descr)
            
            """, preferredStyle: .alert)
    
        alert.setTitle(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.white)
        // Change font and color of message
        alert.setMessage(font: UIFont(name: "Helvetica", size: 18), color: UIColor.systemBackground)
        // Change background color of UIAlertController
        alert.setBackgroudColor(color: UIColor.black)
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler:nil))
        return alert
        
    }
    
//    static func createAlertSheet(title:String,descr:String)-> UIAlertController{
//
//        var alert = UIAlertController(title: title, message: descr, preferredStyle: .actionSheet)
//
//        alert.setTitle(font: UIFont.boldSystemFont(ofSize: 26), color: UIColor.white)
//               // Change font and color of message
//               alert.setMessage(font: UIFont(name: "Helvetica", size: 18), color: UIColor.cyan)
//               // Change background color of UIAlertController
//               alert.setBackgroudColor(color: UIColor.black)
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        return alert
//
//    }
    
    
}

//Extension to UI Alert Controller for cutsom fonts and colors
extension UIAlertController {

  //Set background color of UIAlertController
  func setBackgroudColor(color: UIColor) {
    if let bgView = self.view.subviews.first,
      let groupView = bgView.subviews.first,
      let contentView = groupView.subviews.first {
      contentView.backgroundColor = color
    }
  }

  //Set title font and title color
  func setTitle(font: UIFont?, color: UIColor?) {
    guard let title = self.title else { return }
    let attributeString = NSMutableAttributedString(string: title)//1
    if let titleFont = font {
      attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
        range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
        range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributeString, forKey: "attributedTitle")//4
  }

  //Set message font and message color
  func setMessage(font: UIFont?, color: UIColor?) {
    guard let title = self.message else {
      return
    }
    let attributedString = NSMutableAttributedString(string: title)
    if let titleFont = font {
      attributedString.addAttributes([NSAttributedString.Key.font : titleFont], range: NSMakeRange(0, title.utf8.count))
    }
    if let titleColor = color {
      attributedString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor], range: NSMakeRange(0, title.utf8.count))
    }
    self.setValue(attributedString, forKey: "attributedMessage")//4
  }

  //Set tint color of UIAlertController
  func setTint(color: UIColor) {
    self.view.tintColor = color
  }
}
