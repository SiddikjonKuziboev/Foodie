//
//  MyFirstRealm.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/20/21.
//

import UIKit
import RealmSwift

class MyFirstRealm {
    static var shared = MyFirstRealm()
    var realm: Realm!
    
    init() {
        realm = try! Realm()
     //   print(realm.configuration.fileURL)
        
    }
    
    func saveIteam(iteam: IteamDM) {
        try! realm.write({
            realm.add(iteam,update: .modified)
        })
    }
    
    func setCount(iteam: IteamDM, newCount: Int) {
        
        let arr = realm.objects(IteamDM.self).compactMap{$0}
        
        for i in arr where i._id == iteam._id {
            try! realm.write({
            i.count = newCount
            })
                }
            
        
        
        
    }
    func fetchData() -> [IteamDM] {
         realm.objects(IteamDM.self).compactMap{$0}
    }
    
    
    func deleteIteam(iteam: IteamDM) {
        try! realm.write({
            realm.delete(iteam)
        })
    }
    
    func deleteAll() {
        let a = realm.objects(IteamDM.self)
        try! realm.write{
            for i in a {
                realm.delete(i)
            } 
        }
    }
}
