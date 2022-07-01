//
//  DHPublicWifiConnectViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHPublicWifiConnectViewController: UIViewController {

    var selectDeviceValue: String = ""          // 선택된 기기 종류
    
    @IBOutlet var ssidTextField: UITextField!
    
    @IBOutlet var pwView: UIView! {
        didSet {
            pwView.layer.cornerRadius = 5
            pwView.layer.borderWidth = 1.0
            pwView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var pwTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = nextButton.frame.size.height/2
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "디바이스 추가"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }
    
    // MARK: - wifi 연결 Action
    @IBAction func buttonAction(_ sender: UIButton) {
        let deviceConnectController = DHPublicDeviceConnectViewController.create()
        deviceConnectController.selectDeviceValue = self.selectDeviceValue
        
        self.navigationController?.pushViewController(deviceConnectController, animated: true)
    }
    
}

extension DHPublicWifiConnectViewController {
  static func create() -> DHPublicWifiConnectViewController {
    let controller = DHPublicWifiConnectViewController(nibName: "DHPublicWifiConnectViewController", bundle: nil)
    return controller
  }
}
