//
//  DHRegistDevicePopupViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHRegistDevicePopupViewController: UIViewController {

    var onQRCode: (() -> Void)?
    var onManual: (() -> Void)?
    
    @IBOutlet var popupView: UIView! {
        didSet {
            popupView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet var qrCodeButton: UIButton!
    @IBOutlet var manualDeviceButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: - QRCode / 수동 추가
    @IBAction func deviceRegSelectAction(_ sender: UIButton) {
        switch sender.tag {
        case 2100:
            print("QRCode 스캔")
            self.onQRCode?()
        case 2101:
            print("수동 추가")
            self.onManual?()
        default:
            break
        }
        
        self.dismiss(animated: false, completion: nil)
    }
}

extension DHRegistDevicePopupViewController {
  static func create() -> DHRegistDevicePopupViewController {
    let controller = DHRegistDevicePopupViewController(nibName: "DHRegistDevicePopupViewController", bundle: nil)
    return controller
  }
}
