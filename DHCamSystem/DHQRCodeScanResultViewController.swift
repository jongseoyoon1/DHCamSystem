//
//  DHQRCodeScanResultViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/08.
//

import UIKit

class DHQRCodeScanResultViewController: UIViewController {

    @IBOutlet var deviceImageView: UIImageView!
    @IBOutlet var modelNameLabel: UILabel!
    @IBOutlet var serialNumLabel: UILabel!
    
    @IBOutlet var qrCodeImageView: UIImageView!
    @IBOutlet var qrCodeSaveButton: UIButton! {
        didSet {
            qrCodeSaveButton.layer.cornerRadius = 5
            qrCodeSaveButton.layer.borderWidth = 1.0
            qrCodeSaveButton.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    
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
    
    @IBAction func buttonActions(_ sender: UIButton) {
        switch sender.tag {
        case 2500:
            print("qrcode 저장")
        case 2501:
            let deviceAlert = DHPublicPopupViewController.create()
            deviceAlert.popupType = "1"
            deviceAlert.selectDeviceValue = self.serialNumLabel.text!
            deviceAlert.onConfirm = { popupType, selectDeviceValue in
                DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                    let deviceWifiAlert = DHPublicPopupViewController.create()
                    deviceWifiAlert.popupType = "2"
                    deviceAlert.selectDeviceValue = self.serialNumLabel.text!
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
        default:
            break
        }
    }
    
}

extension DHQRCodeScanResultViewController {
  static func create() -> DHQRCodeScanResultViewController {
    let controller = DHQRCodeScanResultViewController(nibName: "DHQRCodeScanResultViewController", bundle: nil)
    return controller
  }
}

