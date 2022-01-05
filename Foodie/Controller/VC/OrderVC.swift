//
//  OrderVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/6/21.
//

import UIKit
import SwiftyJSON
import Alamofire

class OrderVC: UIViewController {
    @IBOutlet var orderLbl: UILabel!
    @IBOutlet weak var conView: UIView!
    @IBOutlet weak var tabView: UITableView!{
        didSet {
            tabView.register(OrderCell.nib(), forCellReuseIdentifier: OrderCell.identifair)
            tabView.delegate = self
            tabView.dataSource = self
            tabView.separatorStyle = .none
            tabView.rowHeight = 250
        }
    }
    
   
    @IBOutlet var orderLabel: UILabel!
    @IBOutlet var uiImage: UIImageView!
    
    var data: [OrderDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getOrder()
        navigationItem.title = "History"
        tabView.reloadData()
    }
    
    
    func setTextLbael(){
//        if UIScreen.main.bounds.height < 650 {
//            orde.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//        }
    }
    
    func getOrder() {
        AF.request(base+"/api/order", method: .get, headers: ["Authorization" : Cache.getUserToken()]).responseJSON { response in
            if let data = response.data {
                let json = JSON(data)
                
                for i in json["data"].enumerated() {
                    
                    let a = json["data"][i.offset]
                    var insideOrder:[InsideOrder] = []
                    
                    for i in json["data"][i.offset]["products"].arrayValue {
                        let b = InsideOrder(quantity: i["quantity"].intValue,
                                            id: i["id"].stringValue,
                                            sum: i["sum"].intValue,
                                            category: i["category"].stringValue)
                        insideOrder.append(b)
                    }
                    
                    let s =  OrderDM(
                        createdAt: a["createdAt"].stringValue,
                        products: insideOrder,
                        status: a["status"].stringValue)
                    self.data.append(s)
                   
                    
                }
                self.tabView.reloadData()
                
            }
        }
    }
 
    
    
   
}
extension OrderVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(self.data.count,data)

       return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabView.dequeueReusableCell(withIdentifier: OrderCell.identifair, for: indexPath)as! OrderCell
        cell.updateCell(data: data[indexPath.row], index: indexPath)
       // print(data,"🇺🇿")
        cell.selectionStyle = .none
        cell.tab2View.reloadData()
        return cell
    }
    
    
}
