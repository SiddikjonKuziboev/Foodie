//
//  OrderCell2.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/26/21.
//

import UIKit

class OrderCell2: UITableViewCell {
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblSum: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
    @IBOutlet weak var conView: UIView!
    
    static let identifair = "OrderCell2"
    static func nib()->UINib {
    return UINib(nibName: "OrderCell2", bundle: nil)
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        conView.layer.cornerRadius = 20
        
        
        
    }

    
    
}
