//
//  DHManualRegViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHManualRegViewController: UIViewController {

    @IBOutlet var cam1View: UIView! {
        didSet {
            cam1View.layer.cornerRadius = 10
            cam1View.layer.borderWidth = 1.0
            cam1View.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var cam2View: UIView! {
        didSet {
            cam2View.layer.cornerRadius = 10
            cam2View.layer.borderWidth = 1.0
            cam2View.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var cam3View: UIView! {
        didSet {
            cam3View.layer.cornerRadius = 10
            cam3View.layer.borderWidth = 1.0
            cam3View.layer.borderColor = UIColor.systemGray6.cgColor
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
        
        var selectedDeviceNumber: String = ""
        switch sender.tag {
        case 2200:
            print("첫번째")
            selectedDeviceNumber = "1"
        case 2201:
            print("두번째")
            selectedDeviceNumber = "2"
        case 2202:
            print("새번째")
            selectedDeviceNumber = "3"
        default:
            break
        }
        
        let controller = DHManualRegSerialCodeViewController.create()
        controller.selectDeviceValue = selectedDeviceNumber
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension DHManualRegViewController {
  static func create() -> DHManualRegViewController {
    let controller = DHManualRegViewController(nibName: "DHManualRegViewController", bundle: nil)
    return controller
  }
}
