//
//  DHMemberJoinTableViewCell.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHMemberJoinTableViewCell: UITableViewCell {

    @IBOutlet var hpView: UIView! {
        didSet {
            hpView.layer.cornerRadius = 5
            hpView.layer.borderWidth = 1.0
            hpView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var hpTextField: UITextField!
    @IBOutlet var identifierButton: UIButton!
    
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var duplicateButton: UIButton! {
        didSet {
            duplicateButton.layer.borderWidth = 1.0
            duplicateButton.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    
    @IBOutlet var passwordView: UIView! {
        didSet {
            passwordView.layer.borderWidth = 1.0
            passwordView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var pwCheckImageView: UIImageView!
    
    @IBOutlet var rePasswordView: UIView! {
        didSet {
            rePasswordView.layer.borderWidth = 1.0
            rePasswordView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var rePasswordTextField: UITextField!
    @IBOutlet var rePwCheckImageView: UIImageView!
    
    @IBOutlet var termsCheckButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
