//
//  DHPublicDeviceConnectViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHPublicDeviceConnectViewController: UIViewController {

    var selectDeviceValue: String = ""          // 선택된 기기 종류
    
    @IBOutlet var progress: UIActivityIndicatorView! {
        didSet {
            progress.stopAnimating()
        }
    }
    
    var onFinish: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.progress.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.progress.stopAnimating()
            let regDeviceController = DHPublicRegDeviceSuccessViewController.create()
            regDeviceController.selectDeviceValue = self.selectDeviceValue
            
            self.navigationController?.pushViewController(regDeviceController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "디바이스 추가"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.title = ""
    }

}

extension DHPublicDeviceConnectViewController {
  static func create() -> DHPublicDeviceConnectViewController {
    let controller = DHPublicDeviceConnectViewController(nibName: "DHPublicDeviceConnectViewController", bundle: nil)
    return controller
  }
}
