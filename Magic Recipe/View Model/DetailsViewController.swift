//
//  DetailsViewController.swift
//  Magic Recipe
//
//  Created by Ramya Seshagiri on 23/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import UIKit
import WebKit
class DetailsViewController: UIViewController, WKNavigationDelegate{
    @IBOutlet weak var webView: WKWebView!
    
    var url:String = ""
    var titleName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titleName
        webView.navigationDelegate = self
        loadURL(url: url)
    }
    
    func loadURL(url: String){
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
//            if webView.isLoading == false{
//                let alert = CustomAlert.createAlert(title: "Please wait", descr: "Your recipe is loading!")
//                self.present(alert, animated: true) {
//                    self.webView.reload()
//                }
//            }
            
        }
    }
}
