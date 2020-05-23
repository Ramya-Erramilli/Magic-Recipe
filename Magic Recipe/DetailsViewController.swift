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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        
        if let url = URL(string: "https://www.allrecipes.com/recipe/116899/monterey-turkey-omelet/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
extension WKWebView {
    func load(_ urlString: String) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            load(request)
        }
    }
}
