//
//  MenuVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/28/21.
//

import UIKit

protocol IsPressedDelegate {
    func pressed(bool: Bool)
}

class MenuVC: UIViewController {
    @IBOutlet weak var bigBackgroundView: UIView!
    @IBOutlet var menuViews: [UIView]!
    @IBOutlet weak var menuStack: UIStackView!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var dismissBtnOut: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    @IBOutlet var lines: [UIView]!
    
    var delegate: IsPressedDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bigBackgroundView.transform = .init(translationX: -self.view.frame.width, y: 0)
   
    }
    

    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.bigBackgroundView.transform = .identity

        }
    }
    @IBAction func branchesBtnPressed(_ sender: Any) {
        let vc = BranchesMapVC(nibName: "BranchesMapVC", bundle: nil)
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func dismissBtnPressed(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.bigBackgroundView.transform = .init(translationX: -self.view.frame.width, y: 0)

        }
        delegate?.pressed(bool: true)
        dismiss(animated: false, completion: nil)
    }
    
    
    
    @IBAction func signBtnPressed(_ sender: Any) {
        Cache.saveUserToken(token: nil)
        let vc = WelcomeVC(nibName: "WelcomeVC", bundle: nil)
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = vc
        }
    
    }
    
}
