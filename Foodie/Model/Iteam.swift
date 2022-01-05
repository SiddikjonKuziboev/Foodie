//
//  Iteam.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/20/21.
//

import UIKit
import RealmSwift

class IteamDM: Object {
    @objc dynamic var _id: String?
    @objc dynamic var name: String?
    @objc dynamic var cost: Int = 0
    @objc dynamic var discriptionn: String?
    @objc dynamic var count: Int = 1
    var photo : List<PhotoDM> = List<PhotoDM>()
    @objc dynamic var catName: String?

    override class func primaryKey() -> String? {
        "_id"
    }
    
}
class PhotoDM: Object {
    @objc dynamic var url: String?
}


struct OrderDM {
    var createdAt: String
    var products: [InsideOrder]
    var status: String
}

struct InsideOrder {
    var quantity: Int
    var id: String
    var sum: Int
    var category: String
}

struct PersonalDetailsDM:Codable {
    var name: String
    var email: String?
    var phoneNumber: String
    var address: String?

}

