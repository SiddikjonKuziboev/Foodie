//
//  CVC.swift
//  FoodieApp
//
//  Created by Kuziboev Siddikjon on 06/07/21.
//

import UIKit

class CVC: UICollectionViewCell {
    @IBOutlet weak var imageV: UIImageView!
    
    static func nib() -> UINib{
        UINib(nibName: "CVC", bundle: nil)
    }
    static let id : String = "CVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
