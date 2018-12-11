//
//  Webview.swift
//  EarthQuake
//
//  Created by Son on 11/26/18.
//  Copyright © 2018 NguyenHoangSon. All rights reserved.
//

import UIKit

class Webview: UIViewController, UIWebViewDelegate {


    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var webview: UIWebView!
    var bucketURL: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if bucketURL != nil {
            let request = URLRequest(url: URL(string: bucketURL!)!)
            webview.loadRequest(request)
        }
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
}
