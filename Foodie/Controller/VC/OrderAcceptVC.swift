//
//  OrderAcceptVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/23/21.
//

import UIKit
import Lottie

class OrderAcceptVC: UIViewController {
    
    let animV = AnimationView(name: "done")
    let v = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        v.transform = .init(scaleX: 0.1, y: 0.1)
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3539570183)
        setUpAnimateView()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.v.transform = .identity
        } completion: { _ in
            self.animV.play(fromFrame: 0, toFrame: 36, loopMode: .playOnce, completion: nil)

        }

    }
    func setUpAnimateView() {
        
        view.addSubview(v)
        v.snp.makeConstraints { v in
            v.center.equalToSuperview()
            v.height.width.equalTo(view.snp.width).offset(-32)
        }
        
        v.layer.cornerRadius = 20
        v.backgroundColor = .white
        let btn = UIButton()
        btn.setTitle("OK", for: .normal)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(tapOk), for: .touchUpInside )
        v.addSubview(btn)
        btn.snp.makeConstraints { b in
            b.bottom.equalToSuperview().offset(-20)
            b.left.equalToSuperview().offset(20)
            b.right.equalToSuperview().offset(-20)
            b.height.equalToSuperview().multipliedBy(0.15)
        }
        
       
        animV.backgroundColor = .white
        v.addSubview(animV)
        animV.snp.makeConstraints { v in
            v.top.equalToSuperview().offset(30)
            v.width.height.equalToSuperview().multipliedBy(0.6)
            v.centerX.equalToSuperview()
        }
        
        
        
    }
    
    @objc func tapOk(){

        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = Tabbar()
        }

    }

    

}
