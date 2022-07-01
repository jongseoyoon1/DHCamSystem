//
//  DHPhoneCheckViewController.swift
//  DHCamSystem
//
//  Created by ryu on 2022/05/16.
//

import UIKit
import WebKit
import SVProgressHUD
import SnapKit

class DHPersonalInformationController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
    var popPersonal: WKWebView!
    @IBOutlet var webContainerView: UIView!
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func loadWebPage(_ url: String) {
        let userController = WKUserContentController()
        userController.add(self, name: "jscall")
        
        let configrations = WKWebViewConfiguration()
        configrations.userContentController = userController
        configrations.preferences.javaScriptEnabled = true
        configrations.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        popPersonal = WKWebView(frame: .zero, configuration: configrations)
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        popPersonal.load(myRequest)
        
        popPersonal.translatesAutoresizingMaskIntoConstraints = false
        
        webContainerView.addSubview(popPersonal)
        
        popPersonal.snp.makeConstraints { make in
            make.top.equalTo(self.webContainerView.snp.top)
            make.bottom.equalTo(self.webContainerView.snp.bottom)
            make.leading.equalTo(self.webContainerView.snp.leading)
            make.trailing.equalTo(self.webContainerView.snp.trailing)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebPage("http://seeguard.co.kr/Clause.html")
    }
}
