//
//  DHHomeViewController.swift
//  DHCamSystem
//
//  Created by LaimHurb on 2022/02/07.
//

import UIKit
import LCAddDeviceModule

class DHHomeViewController: UIViewController {
    struct ListType: Decodable {
        var list: CGFloat = 200.0
        var placeHolder: CGFloat = 280.0
    }
    
    var collectionViewWidthValue: CGFloat = 0.0
    var listType: ListType = ListType()
    
    var listData = Array<Any>()
    //var listData: Array<Any> = []
    
    let qrscanController = DHQRCodeScanViewController()
    
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var searchView: UIView! {
        didSet {
            searchView.layer.cornerRadius = searchView.frame.size.height/2
        }
    }
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var allPlayButton: UIButton! {
        didSet {
            allPlayButton.layer.cornerRadius = 5
            allPlayButton.layer.borderWidth = 1.0
            allPlayButton.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    
    @IBOutlet var listTileView: UIView! {
        didSet {
            listTileView.layer.cornerRadius = 5
            listTileView.layer.borderWidth = 1.0
            listTileView.layer.borderColor = UIColor.systemGray6.cgColor
        }
    }
    @IBOutlet var listViewButton: UIButton!
    @IBOutlet var tileViewButton: UIButton!
    
    @IBOutlet var listIconImage: UIImageView!
    @IBOutlet var tileIconImage: UIImageView!
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            flowLayout.estimatedItemSize = .zero
            collectionView.collectionViewLayout = flowLayout
            collectionView.alwaysBounceVertical = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        collectionViewWidthValue = UIScreen.main.bounds.width-40.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
//            self.listData.append("model1")
//            self.listData.append("model2")
//            self.listData.append("model3")
//            self.collectionView.reloadData()
//        }
    }
        
    
    
    // MARK: - 기기 추가 BarButton Action
    @IBAction func deviceRegistBarButtonAction(_ sender: UIBarButtonItem) {
        diviceAdd()
    }
    
    // MARK: - 알림 화면 BarButton Action
    @IBAction func alarmViewBarButtonAction(_ sender: UIBarButtonItem) {
        print("알림 화면")
    }
    
    // MARK: - Button Toggle
    @IBAction func buttonToggleActions(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            print("listButtonOn/Off")
//            listIconImage.image = UIImage(named: "")
//            tileIconImage.image = UIImage(named: "")
        case 200:
            print("tile")
            self.navigationController?.pushViewController(qrscanController, animated: true)
        default:
            break
        }
    }
}

extension DHHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if self.listData.count != 0 {
            return self.listData.count
        } else {
            return 1
        }
        //return self.listData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize: CGSize!
        
        if self.listData.count == 0 {
            cellSize = CGSize(width: collectionViewWidthValue, height: listType.placeHolder)
        } else {
            cellSize = CGSize(width: collectionViewWidthValue, height: listType.list)
        }
//        if indexPath.item == 0 {
//            cellSize = CGSize(width: collectionViewWidthValue, height: listType.list)
//        }
//        if indexPath.item == 1 {
//            cellSize = CGSize(width: collectionViewWidthValue, height: listType.list)
//        }
//        if indexPath.item == 2 {
//            cellSize = CGSize(width: collectionViewWidthValue, height: listType.placeHolder)
//        }
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = DHHomeListCollectionViewCell()
        
        if self.listData.count == 0 {
            
            var placeHolderCell = DHHomeListPlaceHolderCollectionViewCell()
            placeHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeHolderCell", for: indexPath) as! DHHomeListPlaceHolderCollectionViewCell
            
            placeHolderCell.registCamButton.addTarget(self, action: #selector(regCamAction), for: .touchUpInside)
            
            return placeHolderCell
            
        } else {
            print(self.listData[indexPath.row])
//                //if indexPath.item == 0 {
//                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "camCell", for: indexPath) as! DHHomeListCollectionViewCell
//                    // switch On일 시 camOnView 활성화
//                    cell.camOnView.isHidden = false
//                    cell.camOffView.isHidden = true
//
//                    cell.installPlaceLabel.text = "안방"
//
//                    cell.camOnOffLabel.text = "ON"
//                    cell.camOnOffLabel.textColor = UIColor(named: "deviceOnColor")
//                    cell.camOnSwitch.isOn = true
//
//                //}
                //if indexPath.item == 1 {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: "camCell", for: indexPath) as! DHHomeListCollectionViewCell
                    // switch Off일 시 camOffView 활성화
                    cell.camOnView.isHidden = true
                    cell.camOffView.isHidden = false
        
                    cell.installPlaceLabel.text = "주방"
        
                    cell.camOnOffLabel.text = "OFF"
                    cell.camOnOffLabel.textColor = UIColor(named: "deviceOffColor")
                    cell.camOnSwitch.isOn = false
        
                //}
        
            
        }
        
//        if indexPath.item == 0 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "camCell", for: indexPath) as! DHHomeListCollectionViewCell
//            // switch On일 시 camOnView 활성화
//            cell.camOnView.isHidden = false
//            cell.camOffView.isHidden = true
//
//            cell.installPlaceLabel.text = "안방"
//
//            cell.camOnOffLabel.text = "ON"
//            cell.camOnOffLabel.textColor = UIColor(named: "deviceOnColor")
//            cell.camOnSwitch.isOn = true
//
//        }
//        if indexPath.item == 1 {
//            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "camCell", for: indexPath) as! DHHomeListCollectionViewCell
//            // switch Off일 시 camOffView 활성화
//            cell.camOnView.isHidden = true
//            cell.camOffView.isHidden = false
//
//            cell.installPlaceLabel.text = "주방"
//
//            cell.camOnOffLabel.text = "OFF"
//            cell.camOnOffLabel.textColor = UIColor(named: "deviceOffColor")
//            cell.camOnSwitch.isOn = false
//
//        }
//        if indexPath.item == 2 {
//            var placeHolderCell = DHHomeListPlaceHolderCollectionViewCell()
//            placeHolderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeHolderCell", for: indexPath) as! DHHomeListPlaceHolderCollectionViewCell
//
//            placeHolderCell.registCamButton.addTarget(self, action: #selector(regCamAction), for: .touchUpInside)
//
//            return placeHolderCell
//        }
        return cell
    }
    
    // MARK: - 디바이스 등록 버튼 Action
    @objc func regCamAction(_ sender: UIButton) {
        diviceAdd()
    }
    
    func diviceAdd(){
        
        print("##############")
        print("##############")
        print("클릭했음")
        print("##############")
        print("##############")
        
        let vc = DHRouter.object(forURL: "/lechange/addDevice/qrScanVC", withUserInfo: [:])

        if (vc != nil) {
          self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
        }
        
//        let controller = DHRegistDevicePopupViewController.create()
//        controller.onQRCode = {
//            //print("QRCode 스캔 뷰로 이동")
//
//            let qrCodeScanController = DHQRCodeScanResultViewController.create()
//            qrCodeScanController.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(qrCodeScanController, animated: true)
//        }
//
//        controller.onManual = {
//            //print("수동으로 디바이스 추가")
//
//            let manualController = DHManualRegViewController.create()
//            manualController.hidesBottomBarWhenPushed = true
//            self.navigationController?.pushViewController(manualController, animated: true)
//        }
//
//        controller.modalTransitionStyle = .crossDissolve
//        controller.modalPresentationStyle = .overFullScreen
//        self.present(controller, animated: false, completion: nil)

    }
}
