//
//  DHLoginViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit
import LCOpenSDKDynamic
import LCBaseModule
import LCNetworkModule
import SwiftyJSON

class DHLoginViewController: UIViewController {
  let dhNetworkingProtocol = DHNetworkingProtocol()
    
  @IBOutlet var idTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  
  @IBOutlet var loginButton: UIButton! {
    didSet {
      loginButton.layer.cornerRadius = loginButton.frame.size.height/2
    }
  }
  
  @IBOutlet var memberJoinButton: UIButton! {
    didSet {
      memberJoinButton.layer.cornerRadius = memberJoinButton.frame.size.height/2
    }
  }
  
  @IBOutlet var findMyIdButton: UIButton!
  @IBOutlet var findMyPasswordButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    
    
//    Admin Account: 68a5b4e271e34aa2
//    AppId: lc69ca8096fd304e1b
//    AppSecret: f4e37bfe2ed6469393d1dfe281da3d
        
//      NSString *addDeviceModule = NSStringFromClass([LCAddDeviceModule class]);
//      //【*】加载模块，如果外部代码没有引用，则无法加载
//      [DHModule loadModuleByNameArray:@[addDeviceModule]];
      
//[DHUserManager shareInstance] getUserConfigFile];
      
      //[LCLogManager shareInstance].maxLogSize = 10
      //[LCLogManager shareInstance].isCycle = YES;
      //[[LCLogManager shareInstance] startFileLog];
      
      
      
      //LCLogManager.shareInstance().maxLogSize = 10
      //LCLogManager.shareInstance().isCycle = true
      //LCLogManager.shareInstance().startFileLog()
      
    LCApplicationDataManager.setAppIdWith("lc69ca8096fd304e1b")
    LCApplicationDataManager.setAppSecretWith("f4e37bfe2ed6469393d1dfe281da3d")
    LCApplicationDataManager.setHostApiWith("https://openapi.easy4ip.com")
    
    LCAccountInterface.accessTokenWithsuccess { authInfo in
      print(authInfo)
      
      let apiParam = LCOpenSDK_ApiParam()
      apiParam.procotol = .PROCOTOL_TYPE_HTTPS
      apiParam.addr = "openapi.easy4ip.com"
      apiParam.port = 443
      apiParam.token = authInfo.accessToken
      
      let m_hc = LCOpenSDK_Api.init(openApi: apiParam)
      print(m_hc)
    } failure: { error in
      print(error)
    }
      
//      GlobalSingleton.sharedInstance.showAlertView("테스트")
      
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.navigationController?.isNavigationBarHidden = true
  }
  
  @IBAction func buttonActions(_ sender: UIButton) {
    switch sender.tag {
    case 2000:
        //print("로그인")
        
        let userEmail: Any = idTextField.text!
        let userPassword : Any = passwordTextField.text!
        
        let params : [String: Any] = [
            "action": "select",
            "email" : userEmail,
            "password" : userPassword,
            "os" : "IOS"
        ] as Dictionary
        
        
//        let param1 = "json={""action"":""select"",""where"":{""email"":""songchic2@gmail.com"",""password"":""1234""}}"
//        let paramData1 = param1.data(using: .utf8)
        
        dhNetworkingProtocol.autoLoginProcess(params) { result in
            print(result.result)
            if result.result == "success" {
                let controller = DHMainTabBarController.create()
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: false, completion: nil)
            } else {
                GlobalSingleton.sharedInstance.showAlertView("계정 또는 비밀번호가 유효하지 않습니다.")
            }
        }
        
    case 2001:
      //print("회원가입")
      let controller = DHMemberJoinViewController.create()
      self.navigationController?.pushViewController(controller, animated: true)
        
        
    case 2002:
      print("아이디 찾기")
    case 2003:
      print("비밀번호 찾기")
      
    default:
      break
    }
  }
  
}

extension DHLoginViewController {
  static func create() -> DHLoginViewController {
    let controller = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "dhLoginViewController") as! DHLoginViewController
    return controller
  }
}
