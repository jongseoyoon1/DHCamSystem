//
//  DHManualRegSerialCodeViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHManualRegSerialCodeViewController: UIViewController {

    var selectDeviceValue: String = ""          // 선택된 기기 종류
    
    @IBOutlet var serialView: UIView! {
        didSet {
            serialView.layer.cornerRadius = 5
            serialView.layer.borderWidth = 1.0
            serialView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var serialTextField: UITextField!
    
    @IBOutlet var safeCodeView: UIView! {
        didSet {
            safeCodeView.layer.cornerRadius = 5
            safeCodeView.layer.borderWidth = 1.0
            safeCodeView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var safeCodeTextField: UITextField!
    
    @IBOutlet var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = nextButton.frame.self.height/2
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
    
    // MARK: - 다음 버튼 Action
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let deviceAlert = DHPublicPopupViewController.create()
        deviceAlert.popupType = "1"
        deviceAlert.selectDeviceValue = self.selectDeviceValue
        deviceAlert.onConfirm = { popupType, selectDeviceValue in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                let deviceWifiAlert = DHPublicPopupViewController.create()
                deviceWifiAlert.popupType = "2"
                deviceAlert.selectDeviceValue = self.selectDeviceValue
                deviceWifiAlert.onConfirm = { popupType, selectDeviceValue in
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        let deviceWifiConnectAlert = DHPublicConnetDevicePopupViewController.create()
                        deviceWifiConnectAlert.onFinish = {
                            let wifiConnectController = DHPublicWifiConnectViewController.create()
                            wifiConnectController.selectDeviceValue = selectDeviceValue
                            
                            self.navigationController?.pushViewController(wifiConnectController, animated: true)
                        }
                        deviceWifiConnectAlert.modalTransitionStyle = .crossDissolve
                        deviceWifiConnectAlert.modalPresentationStyle = .overFullScreen
                        self.present(deviceWifiConnectAlert, animated: false, completion: nil)
                    }
                }
                deviceWifiAlert.onCancel = { }
                deviceWifiAlert.modalTransitionStyle = .crossDissolve
                deviceWifiAlert.modalPresentationStyle = .overFullScreen
                self.present(deviceWifiAlert, animated: false, completion: nil)
            }
        }
        
        deviceAlert.onCancel = { }
        
        deviceAlert.modalTransitionStyle = .crossDissolve
        deviceAlert.modalPresentationStyle = .overFullScreen
        self.present(deviceAlert, animated: false, completion: nil)
    }
}

extension DHManualRegSerialCodeViewController {
  static func create() -> DHManualRegSerialCodeViewController {
    let controller = DHManualRegSerialCodeViewController(nibName: "DHManualRegSerialCodeViewController", bundle: nil)
    return controller
  }
}
