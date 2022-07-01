//
//  DHMainTabBarController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2021/12/31.
//

import UIKit

class DHMainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    
}

extension DHMainTabBarController {
    static func create() -> DHMainTabBarController {
        let controller = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "dhMainTabBarController") as! DHMainTabBarController
        return controller
    }
}

