//
//  CartTVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on  7/5/21.
//

import UIKit
import RealmSwift
class CartTVC: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var resultLbl: UILabel!
    
    var count = 1 {
        didSet{
            resultLbl.text! = "\(count)"
        }
    }
    var sum = 1900 {
        didSet{
            sumLbl.text! = "#\(sum)"
        }
    }
    var iteam : IteamDM?
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var sumLbl: UILabel!
    @IBOutlet var contextLbl: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var stack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
   
    func setTextLbael(){
        
        if UIScreen.main.bounds.height < 650 {
            contextLbl.font = UIFont.systemFont(ofSize: 11)
            sumLbl.font = UIFont.systemFont(ofSize: 12)
            plusBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        }
        
    }
    
    @IBAction func minusBtnPressed(_ sender: Any) {
        if count >= 1 {
            count -= 1
        }
       
        sum = count*iteam!.cost
        //print(sum,count,"--")
        MyFirstRealm.shared.setCount(iteam: iteam!, newCount: count)
    }
    @IBAction func plusBtnPressed(_ sender: Any) {
        count += 1
        sum = count*iteam!.cost
        MyFirstRealm.shared.setCount(iteam: iteam!, newCount: count)
        //print(sum,iteam?.cost,iteam?.count)

    }
    
    func updateCell(iteam: IteamDM) {
        activityIndicator.stopAnimating()
        self.iteam = iteam
        contextLbl.text = iteam.name
        self.count = iteam.count
       // print(count,12)
        sumLbl.text = "#\(iteam.cost*iteam.count)"
        resultLbl.text = "\(iteam.count)"
        imgView.sd_setImage(with: URL(string: base+iteam.photo[0].url!), placeholderImage: #imageLiteral(resourceName: "image1"))
        
    }

}
