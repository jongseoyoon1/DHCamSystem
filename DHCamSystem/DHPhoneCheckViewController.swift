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

//protocol aaa: AnyObject {
//    func successRes(hp: String, sex: String, aa: String)
//}

class DHPhoneCheckViewController: UIViewController, WKNavigationDelegate, WKScriptMessageHandler {
    
//    weak var delegate: aaa?
    
    var kcpActivity: WKWebView!
    @IBOutlet var webContainerView: UIView!
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        print("message: \(message)")
        
        if let messageBody = message.body as? Dictionary<String, Any> {
            print(messageBody)
            if messageBody["command"] as! String == "phoneCheck" {
//                print(messageBody["birth_day"])
                
                let phone_no = messageBody["number"] as! String
                let user_name = messageBody["name"] as! String
                let birth_day = messageBody["birth"] as! String

                
                self.navigationController?.popViewController(animated: true)
                onFinish!(phone_no, user_name, birth_day)
                
                //self.delegate?.successRes(hp: phone_no, sex: user_name, aa: birth_day)
            }
        }
    }
    
    
    var onFinish: ((_ hp: String, _ sex: String, _ birth: String) -> Void)?
    
    func loadWebPage(_ url: String) {
        let userController = WKUserContentController()
        userController.add(self, name: "jscall")
        
        let configrations = WKWebViewConfiguration()
        configrations.userContentController = userController
        configrations.preferences.javaScriptEnabled = true
        configrations.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        kcpActivity = WKWebView(frame: .zero, configuration: configrations)
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        kcpActivity.load(myRequest)
        
        kcpActivity.translatesAutoresizingMaskIntoConstraints = false
        
        webContainerView.addSubview(kcpActivity)
        
        kcpActivity.snp.makeConstraints { make in
            make.top.equalTo(self.webContainerView.snp.top)
            make.bottom.equalTo(self.webContainerView.snp.bottom)
            make.leading.equalTo(self.webContainerView.snp.leading)
            make.trailing.equalTo(self.webContainerView.snp.trailing)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebPage("https://homecam.seeguard.co.kr:8443/kcpcert_enc_linux_php/SMART_ENC/smart_start.php")
    }
}
