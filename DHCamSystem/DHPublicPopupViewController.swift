//
//  DHPublicPopupViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHPublicPopupViewController: UIViewController {
    
    var selectDeviceValue: String = ""          // 선택된 기기 종류
    var popupType: String = ""      // 팝업에 따른 이벤트 처리를 위해 타입을 넘겨야 함
    
    @IBOutlet var popupView: UIView! {
        didSet {
            popupView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var confirmButton: UIButton!
    
    var onConfirm: ((_ popupType: String, _ selectedDeviceValue: String) -> Void)?
    var onCancel: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = "알림"
        descriptionLabel.text = popupType == "1" ? "1. 디바이스의 전원을 확인해주세요.\n2. 홈캠 LED가 녹색으로 깜빡이는지 확인해주세요.\n만약 녹색으로 계속 깜빡이지 않는다면" : "SEE GUARD 가 'DAP-XXXXXXXX'\nWi-Fi에 연결하려고 합니다. 시도하시겠습니까?"
        
        confirmButton.setTitle(popupType == "1" ? "확인" : "연결", for: .normal)
    }
    
    // 확인 / 취소 버튼 Action
    @IBAction func buttonActions(_ sender: UIButton) {
        switch sender.tag {
        case 2300:
            print("확인")
            self.dismiss(animated: false) {
                self.onConfirm?(self.popupType, self.selectDeviceValue)
            }
        case 2301:
            print("취소")
            self.onCancel?()
            self.dismiss(animated: false, completion: nil)
        default:
            break
        }
        
        
    }
    
}

extension DHPublicPopupViewController {
  static func create() -> DHPublicPopupViewController {
    let controller = DHPublicPopupViewController(nibName: "DHPublicPopupViewController", bundle: nil)
    return controller
  }
}
