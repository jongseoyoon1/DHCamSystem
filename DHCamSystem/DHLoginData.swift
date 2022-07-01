//
//  DHLoginData.swift
//  DHCamSystem
//
//  Created by ryu on 2022/04/19.
//

import UIKit

class DHLoginData: NSObject {
    struct LoginData: Decodable {
        //let status: Int // 200...500
        let result: String
        let member: LoginTotalData?
    }
    
    struct LoginTotalData: Decodable {
        let hm_idx      : String?
        let hm_id       : String?
        let hm_password : String?
        let hm_code     : String?
        let hm_email    : String?
        let hm_regdate  : String?
        let hm_machine  : String?
        let hm_token    : String?
        let hm_del      : String?
    }
}
