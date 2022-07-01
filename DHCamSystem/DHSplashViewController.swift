//
//  DHSplashViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHSplashViewController: UIViewController {
    
    @IBOutlet var splashImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if UIScreen.main.bounds.height >= 812 {
            // Notch Device
            splashImageView.image = UIImage(named: "splash_2688")
        }
        else {
            splashImageView.image = UIImage(named: "splash_2208")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let controller = DHLoginViewController.create()
            self.navigationController?.pushViewController(controller, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension DHSplashViewController {
  static func create() -> DHSplashViewController {
    let controller = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "dhSplashViewController") as! DHSplashViewController
    return controller
  }
}
