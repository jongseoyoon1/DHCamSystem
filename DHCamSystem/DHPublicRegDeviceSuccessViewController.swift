//
//  DHPublicRegDeviceSuccessViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/08.
//

import UIKit

class DHPublicRegDeviceSuccessViewController: UIViewController {
    
    var selectDeviceValue: String = ""          // 선택된 기기 종류
    
    @IBOutlet var deviceNameView: UIView! {
        didSet {
            deviceNameView.layer.cornerRadius = 5
            deviceNameView.layer.borderWidth = 1.0
            deviceNameView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var deviceNameTextField: UITextField!
    
    @IBOutlet var nationTimeLabel: UILabel!
    @IBOutlet var nationSelectionButton: UIButton!
    
    @IBOutlet var confirmButton: UIButton! {
        didSet {
            confirmButton.layer.cornerRadius = confirmButton.frame.size.height/2
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
    
    // MARK: - 국가/지역 선택 Action
    @IBAction func buttonAction(_ sender: UIButton) {
        
    }
    
    // MARK: - 완료 Action
    @IBAction func confirmAction(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}

extension DHPublicRegDeviceSuccessViewController {
  static func create() -> DHPublicRegDeviceSuccessViewController {
    let controller = DHPublicRegDeviceSuccessViewController(nibName: "DHPublicRegDeviceSuccessViewController", bundle: nil)
    return controller
  }
}
