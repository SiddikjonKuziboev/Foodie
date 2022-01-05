//
//  Tabbar.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/5/21.
//

import UIKit

class Tabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = DeliciousFoodVC(nibName: "DeliciousFoodVC", bundle: nil)
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        let nav = UINavigationController(rootViewController: vc1)
        
        let vc2 = ProfileVC(nibName: "ProfileVC", bundle: nil)
        vc2.tabBarItem.image = UIImage(systemName: "person")
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let vc3 = OrderVC(nibName: "OrderVC", bundle: nil)
        vc3.tabBarItem.image = UIImage(systemName: "timer")
        let nav3 = UINavigationController(rootViewController: vc3)
        
        self.tabBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        self.tabBar.tintColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
        

        viewControllers = [nav,nav2,nav3]
        selectedIndex = 0

        
    }
    

  

}
