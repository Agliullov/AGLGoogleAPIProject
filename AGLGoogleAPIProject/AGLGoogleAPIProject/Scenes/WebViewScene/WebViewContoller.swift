//
//  WebViewContoller.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 10.02.2023.
//

import UIKit
import WebKit

final class WebViewContoller: UIViewController, WKNavigationDelegate {
    
    var urlString: String?
    
    private var webView: WKWebView = {
        let view = WKWebView()
        return view
    }()
    
    override func loadView() {
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
}
