//
//  DHHomeListCollectionViewCell.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHHomeListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var installPlaceLabel: UILabel!
    @IBOutlet var camOnOffLabel: UILabel!
    @IBOutlet var camOnSwitch: UISwitch!
    @IBOutlet var camOnMoreButton: UIButton!
    @IBOutlet var camOnView: UIView! {
        didSet {
            camOnView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet var camPlayButton: UIButton!
    
    @IBOutlet var camOffView: UIView! {
        didSet {
            camOffView.layer.cornerRadius = 10.0
        }
    }
    @IBOutlet var camOffModelImageView: UIImageView!
    @IBOutlet var camModelNameLabel: UILabel!
    @IBOutlet var camSerialNumLabel: UILabel!
    
}
