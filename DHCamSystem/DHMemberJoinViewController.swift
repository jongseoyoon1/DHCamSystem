//
//  DHMemberJoinViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit
import SwiftyJSON
import WebKit

class DHMemberJoinViewController: UIViewController, WKUIDelegate {
    let dhNetworkingProtocol = DHNetworkingProtocol()
    
    var webView: WKWebView!
    
    
    var hpTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var rePasswordTextField: UITextField!
    var duplicateEmailCheck = "N"
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var memberJoinButton: UIButton! {
        didSet {
            memberJoinButton.layer.cornerRadius = memberJoinButton.frame.size.height/2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    //이메일 중복체크
    @IBAction func duplicateEmail(_ sender: UIButton) {
        
        if GlobalSingleton.sharedInstance.isValidEmailAddress(emailAddressString: emailTextField.text!) == false {
            GlobalSingleton.sharedInstance.showAlertView("이메일 주소를 입력해주세요.")
            return
        }
    
        let inputEmail : Any = emailTextField.text!

        let paramsEmail : [String: Any] = [
            "action": "select",
            "email" : inputEmail
        ] as Dictionary
        
        dhNetworkingProtocol.emailProcess(paramsEmail) { result in
            print(result.result)
            if result.result == "success" {
                print("값이 있음")
//                let controller = DHMainTabBarController.create()
//                controller.modalPresentationStyle = .fullScreen
//                self.present(controller, animated: false, completion: nil)
            } else {
                GlobalSingleton.sharedInstance.showAlertView("정보값이 유효하지 않습니다.")
            }
        }
        
    }
    
    //회원가입
    @IBAction func joinSend(_ sender: Any) {
        
        
        if hpTextField.text!.isEmpty {
            GlobalSingleton.sharedInstance.showAlertView("본인인증을 진행해주세요.")
            return
        }
        
        if GlobalSingleton.sharedInstance.isValidEmailAddress(emailAddressString: emailTextField.text!) == false {
            GlobalSingleton.sharedInstance.showAlertView("이메일 주소를 입력해주세요.")
            return
        }
        
        if passwordTextField.text!.isEmpty {
            GlobalSingleton.sharedInstance.showAlertView("패스워드를 입력해주세요.")
            return
        }
        
        
        let userPhone: Any = hpTextField.text!
        let userEmail : Any = emailTextField.text!
        let userPassword : Any = passwordTextField.text!
        
        let params : [String: Any] = [
            "action": "insert",
            "email" : userEmail,
            "password" : userPassword,
            "phone" : userPhone,
            "os" : "IOS"
            
        ] as Dictionary


        dhNetworkingProtocol.joinProcess(params) { result in
            print(result.result)
            if result.result == "success" {
                let controller = DHMainTabBarController.create()
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: false, completion: nil)
            } else {
                GlobalSingleton.sharedInstance.showAlertView("정보값이 유효하지 않습니다.")
            }
        }
    }
}

extension DHMemberJoinViewController: UITableViewDataSource, UITableViewDelegate {
//extension DHMemberJoinViewController: UITableViewDataSource, UITableViewDelegate, aaa {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = DHMemberJoinTableViewCell()
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! DHMemberJoinTableViewCell
        }
        if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "hpCell", for: indexPath) as! DHMemberJoinTableViewCell
            //self.hpValue = cell.hpTextField.text ?? ""
            if self.hpTextField == nil {
                self.hpTextField = cell.hpTextField
            }
            
            cell.identifierButton.addTarget(self, action: #selector(identifierAction), for: .touchUpInside)
        }
        if indexPath.row == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! DHMemberJoinTableViewCell
            //self.emailValue = cell.emailTextField.text ?? ""
            if self.emailTextField == nil {
                self.emailTextField = cell.emailTextField
            }
        }
        if indexPath.row == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "pwCell", for: indexPath) as! DHMemberJoinTableViewCell
            if self.passwordTextField == nil {
                self.passwordTextField = cell.passwordTextField
            }
        }
        if indexPath.row == 4 {
            cell = tableView.dequeueReusableCell(withIdentifier: "rePwCell", for: indexPath) as! DHMemberJoinTableViewCell
            if self.rePasswordTextField == nil {
                self.rePasswordTextField = cell.rePasswordTextField
            }
        }
        if indexPath.row == 5 {
            cell = tableView.dequeueReusableCell(withIdentifier: "termsCell", for: indexPath) as! DHMemberJoinTableViewCell
        }
        
        return cell
    }
    
    
    //kcp 본인인증
    @objc func identifierAction(_ sender: UIButton) {
        let dhPhoneCheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "dhPhoneCheckViewController") as! DHPhoneCheckViewController
//        dhPhoneCheckViewController.delegate = self
        dhPhoneCheckViewController.onFinish = { phone_no, user_name, birth_day in
            self.hpTextField.text = phone_no
        }
        
        self.navigationController?.pushViewController(dhPhoneCheckViewController, animated: true)
        
    }
    
    //이용약관 및 개인정보처리방침(URL 링크)
    @IBAction func personalinformation(_ sender: Any) {
        let dhPhoneCheckViewController = self.storyboard?.instantiateViewController(withIdentifier: "dhPersonalInformationController") as! DHPersonalInformationController
        
        self.navigationController?.pushViewController(dhPhoneCheckViewController, animated: true)
    }
    
    // delegate
//    func successRes(hp: String, sex: String, aa: String) {
//        print(hp)
//    }
}

extension DHMemberJoinViewController {
  static func create() -> DHMemberJoinViewController {
    let controller = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "dhMemberJoinViewController") as! DHMemberJoinViewController
    return controller
  }
}
