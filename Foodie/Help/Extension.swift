//
//  Extension.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/24/21.
//

import UIKit
extension UIViewController {
    
    var isSmallScreen : Bool {
        return UIScreen.main.bounds.height < 600
    } 
}
//MARK: - UINavigation Bar
extension UINavigationBar {
    func shouldRemoveShadow(_ value: Bool) -> Void {
        self.setValue(value, forKey: "hidesShadow")
    }
}

