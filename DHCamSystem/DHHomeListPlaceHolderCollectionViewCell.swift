//
//  DHHomeListPlaceHolderCollectionViewCell.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit

class DHHomeListPlaceHolderCollectionViewCell: UICollectionViewCell {
    @IBOutlet var notInstallMoreButton: UIButton!
    @IBOutlet var registCamButton: UIButton!
    @IBOutlet var placeHolderView: UIView! {
        didSet {
            placeHolderView.layer.cornerRadius = 10.0
        }
    }
    
}
