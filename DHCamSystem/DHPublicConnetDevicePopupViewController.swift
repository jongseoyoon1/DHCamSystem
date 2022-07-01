//
//  DHPublicConnetDevicePopupViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHPublicConnetDevicePopupViewController: UIViewController {

    @IBOutlet var popupView: UIView! {
        didSet {
            popupView.layer.cornerRadius = 10.0
        }
    }
    
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
            self.dismiss(animated: false, completion: nil)
            self.onFinish?()
        }
    }
    
}

extension DHPublicConnetDevicePopupViewController {
  static func create() -> DHPublicConnetDevicePopupViewController {
    let controller = DHPublicConnetDevicePopupViewController(nibName: "DHPublicConnetDevicePopupViewController", bundle: nil)
    return controller
  }
}
