//
//  WebViewVC.swift
//  NetflixClone
//
//  Created by Ahmet Utlu on 13.03.2023.
//

import UIKit
import WebKit

class WebViewVC: BaseVC {
    
    var urlString: String?
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        
        webView.navigationDelegate = self
        
        return webView
    }()
    
    override func setupViews() {
        super.setupViews()
        view.addSubviews([webView])
        setURL()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func setURL() {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
}

extension WebViewVC: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
    }
}
