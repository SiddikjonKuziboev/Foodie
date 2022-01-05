//
//  CollectionViewCell.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/6/21.
//

import UIKit
import Lottie
class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imgConView: UIView!
    
    @IBOutlet weak var animateView: UIView!
    
    @IBOutlet weak var imdConheight: NSLayoutConstraint!
    
    var animationView = AnimationView()
    override func awakeFromNib() {
        super.awakeFromNib()
        animate()
        containerView.layer.shadowColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        containerView.layer.shadowOffset = CGSize(width: 2 , height: 2)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 30
       screenSize()
    }
    func animate(){
        
        animationView = AnimationView(name: "8774-loading")
        animationView.frame = CGRect(x: 0, y: 0, width:imgConView.frame.width , height: imgConView.frame.height)
        animateView.addSubview(animationView)
      //  animationView.play()
    }
    
    
    func screenSize() {
        if !(UIScreen.main.bounds.height < 600) {
            imgHeight.constant = 50
            imgConView.layer.cornerRadius = 50
            imageView.layer.cornerRadius = 50
            imdConheight.constant = 100
            lblCost.font = UIFont.systemFont(ofSize: 12)
            lblName.font = UIFont.systemFont(ofSize: 17)
            imdConheight.constant = 100
        }
    }
    
}
