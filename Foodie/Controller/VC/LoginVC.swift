//
//  LoginVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/8/21.
//

import UIKit
import SwiftyJSON
import Alamofire

var base = "https://foodie-backend-v7tmm.ondigitalocean.app"

class LoginVC: UIViewController {
    
    @IBOutlet weak var conView: UIView!{
        didSet {
            conView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            conView.layer.shadowOffset = CGSize(width: 1, height: 1)
            conView.layer.shadowOpacity = 0.4
            conView.layer.shadowRadius = 6
            
        }
    }
    //MARK: Login
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var loginContainerView: UIView!
    
    @IBOutlet weak var forgetBtnOut: UIButton!
    
    
    @IBOutlet weak var conBtnOut: UIButton!
    
    
    @IBOutlet weak var loginLineView: UIView!
    
    @IBOutlet weak var signBtnOut: UIButton!
    
    @IBOutlet weak var loginBtnOut: UIButton!
    
    //MARK: Sign-Up
    @IBOutlet weak var signContainerView: UIView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var txtBirthday: UITextField!
    @IBOutlet weak var txtSignPassword: UITextField!
    
    
    var datePicker = UIDatePicker()
    var isPressed: Bool = false
    var profileData : PersonalDetailsDM?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signContainerView.isHidden = true
        toolbar()
    }
    
    
  
    
    func signUp() {
       
        let params: [String : String] = [
            "name":txtName.text!,
            "phone":phone.text!,
            "birthday":txtBirthday.text!,
            "password":txtSignPassword.text!
        ]
        profileData = PersonalDetailsDM(name: txtName.text!,
                                        phoneNumber: phone.text!)
        let encoder = JSONEncoder()
        if let encode = try? encoder.encode(profileData) {
            UserDefaults.standard.setValue(encode, forKeyPath: "22")
            
        }
    
            
        AF.request(base + "/api/users", method: .post, parameters: params, encoding: URLEncoding.queryString).responseJSON { response in

                if let data = response.data {
                   
                    let d = JSON(data)
                   // print(d["success"].boolValue)
                    if d["success"].boolValue {
                    let token = d["token"].stringValue
                        Cache.saveUserToken(token: token)
                    let vc = Tabbar()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    func login() {
       
        let params: [String : String] = [
            "phone":txtPhone.text!,
            "password": txtPassword.text!
            ]
 
        AF.request(base + "/api/auth", method: .post, parameters: params, encoding: URLEncoding.queryString).responseJSON { [self] response in
            
            
                if let data = response.data {
                    let d = JSON(data)
                    if d["success"].boolValue {
                        let vc = Tabbar()
                        Cache.saveUserToken(token:d["token"].stringValue )
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                    
            }
        }
    }

    
    
    
    func setupRadius(){
        conBtnOut.layer.cornerRadius = conBtnOut.frame.height/2
        
        conView.layer.cornerRadius = conView.frame.height/5
        conView.backgroundColor = .white
        conView.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        conView.layer.shadowOffset = CGSize(width: 0, height: 0)
        conView.layer.shadowRadius = 3
        conView.layer.shadowOpacity = 0.5
        signContainerView.isHidden = true
    }
    
    
    func toolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        toolbar.isTranslucent = true
        let selectedBtn = UIBarButtonItem(title: "Select", style: .done, target: self, action: #selector(selectBtnPressed))
        let spaceBtn =  UIBarButtonItem(systemItem: .flexibleSpace)
        selectedBtn.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        txtBirthday.inputAccessoryView = toolbar
        toolbar.items = [spaceBtn,selectedBtn]
        //MARK: Data Picker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = UIDatePicker.Mode.date
        txtBirthday.inputView = datePicker
        datePicker.addTarget(self, action: #selector(pickerDateChengedValue), for: .valueChanged)
       
    }
    
    
    @objc func pickerDateChengedValue() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        txtBirthday.text = dateFormatter.string(from: datePicker.date)
        
    }
    
    
    @objc func selectBtnPressed() {
        if txtSignPassword.isFirstResponder {
            txtSignPassword.resignFirstResponder()
            txtBirthday.becomeFirstResponder()
        } else {
            txtBirthday.resignFirstResponder()
        }
    }
    
    
    @IBAction func signBtnPressed(_ sender: Any) {
        isPressed = false
        
        if !isPressed{
            forgetBtnOut.isHidden = true
            loginContainerView.isHidden = true
            signContainerView.isHidden = false
            UIView.animate(withDuration: 0.3) { [self] in
                self.loginLineView.transform = CGAffineTransform(translationX: 165, y: 0)
                isPressed = true
            }
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        isPressed = true
        if isPressed{
            forgetBtnOut.isHidden = false
            loginContainerView.isHidden = false
            signContainerView.isHidden = true
            
            UIView.animate(withDuration: 0.3) { [self] in
                self.loginLineView.transform = .identity
                isPressed = false
            }
        }
    }
    
    @IBAction func continueBtnPerssed(_ sender: Any) {
        
        if !isPressed {
          login()
            
        }else{
        signUp()
            
        }
    }
    
    
    @IBAction func forgetBtnPressed(_ sender: Any) {
        
    }
    
    
}
