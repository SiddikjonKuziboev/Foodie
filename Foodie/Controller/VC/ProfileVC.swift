//
//  ProfileVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/4/21.
//

import UIKit

class ProfileVC: UIViewController,DMDelegate {
    func sendData(_ a: PersonalDetailsDM) {
        data = a
        
            emaliLbl.text = a.email
            aboutAddressLbl.text = a.address
            phoneNumberLbl.text = a.phoneNumber
            personNameLbl.text = a.name
        
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")!

    }
    
    
    @IBOutlet var views: [UIView]!{
        didSet {
            for i in views {
                i.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.08105670853)
                i.layer.shadowOffset = CGSize(width: 1, height: 1)
                i.layer.shadowRadius = 3
                i.layer.shadowOpacity = 1
            }
        }
    }
    
    @IBOutlet weak var personNameLbl: UILabel!
    @IBOutlet weak var emaliLbl: UILabel!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var aboutAddressLbl: UILabel!
    
    @IBOutlet weak var btnsHeights: NSLayoutConstraint!
    @IBOutlet weak var updateBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var imgView: UIImageView!
    
    var data: PersonalDetailsDM?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")

        if let dat = UserDefaults.standard.data(forKey: "22"){
            let decoder = JSONDecoder()
            if let decode = try? decoder.decode(PersonalDetailsDM.self, from: dat) {
                data = decode
            }
          
        }
        
        if let d = data {
            emaliLbl.text = d.email
            aboutAddressLbl.text = d.address
            phoneNumberLbl.text = d.phoneNumber
            personNameLbl.text = d.name
        }
        setUp()
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func setUp() {
        if isSmallScreen {
            btnsHeights.constant = 45
            updateBtnHeight.constant = 55
            emaliLbl.font = UIFont.systemFont(ofSize: 12)
            phoneNumberLbl.font = UIFont.systemFont(ofSize: 12)
            aboutAddressLbl.font = UIFont.systemFont(ofSize: 12)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imgView.image = UserDefaults.standard.imageForKey(key: "Img")
       // print("image",UserDefaults.standard.imageForKey(key: "Img")!)
        if let d = data {
            emaliLbl.text = d.email
            aboutAddressLbl.text = d.address
            phoneNumberLbl.text = d.phoneNumber
            personNameLbl.text = d.name
        }
    }
    
    @IBAction func changeBtnPressed(_ sender: Any) {
        
        let vc = PresonalDetailsVC(nibName: "PresonalDetailsVC", bundle: nil)
        
        vc.modalPresentationStyle = .overFullScreen
             vc.delegate = self
        present(vc, animated: true, completion: nil)
    }

    @IBAction func orderBtnPressed(_ sender: Any) {
        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
