//
//  Cache.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/9/21.
//

import UIKit

class Cache{
 
class func saveUserToken(token: String?) {
    UserDefaults.standard.setValue(token, forKey: Constants.TOKEN)
}

class func isUserLogged()-> Bool {
    return UserDefaults.standard.string(forKey: Constants.TOKEN) != nil
  
}
    class func getUserToken()-> String {
        return UserDefaults.standard.string(forKey: Constants.TOKEN) ?? "0"
      
    }
}
