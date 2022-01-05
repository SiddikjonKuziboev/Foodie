//
//  CartVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/5/21.
//

import UIKit
import RealmSwift
import SDWebImage
import SwiftyJSON
import Alamofire


class CartVC: UIViewController {
  
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "CartTVC", bundle: nil), forCellReuseIdentifier: "CartTVC")
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 150, right: 0)
        }
    }
    
    
    var data = [IteamDM]()
    var realm : Realm?
    let refreshControl = UIRefreshControl()
    ///var uy: IteamDM?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        fetchData()
        navigationController?.navigationBar.prefersLargeTitles = false

       refreshController()
        
    }
    
    
    func refreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    func fetchData() {
        data = MyFirstRealm.shared.fetchData()
        tableView.reloadData()
    }

    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
    }
    
    
    @IBAction func completeBtnPressed(_ sender: Any) {
        var order = [[String:String]]()
        //refreshControl.endRefreshing()
        for i in data {
            var a = [String:String]()
             a = [
                "product_id" : i._id!,
                "cat" : i.catName!,
                "name" : i.name!,
                "quantity" : "\(i.count)",
                "sum" : "\(i.count*i.cost)"
            ]
            order.append(a)
        }

        let parameter = ["order":order]
        let header : HTTPHeaders = ["Authorization":Cache.getUserToken()]
        AF.request(base+"/api/order", method: .post,parameters: parameter, encoding: URLEncoding.queryString, headers: header ).responseJSON { response in

            if let data = response.data {
                let d = JSON(data)
                if d["success"].boolValue {
                    print(d["success"].boolValue,232)
                    MyFirstRealm.shared.deleteAll()
                    self.tableView.reloadData()
                    self.fetchData()
                    let vc = OrderAcceptVC()
                    vc.modalPresentationStyle = .overFullScreen
                    self.present(vc, animated: false, completion: nil)
                }
            }
        }


    }
}


extension CartVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let vc = tableView.dequeueReusableCell(withIdentifier: "CartTVC", for: indexPath) as! CartTVC
        vc.setTextLbael()
        vc.updateCell(iteam: data[indexPath.row])
       
        return vc
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = OrderVC(nibName: "OrderVC", bundle: nil)
//        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if UIScreen.main.bounds.height < 650 {
                self.tableView.rowHeight = 40
            }
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let v1 = UIView()
        v1.backgroundColor = .systemGray6
        let deleteAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        // Perform your action here
            MyFirstRealm.shared.deleteIteam(iteam: self.data[indexPath.row])
            self.data.remove(at: indexPath.row)
            tableView.reloadData()
          completion(true)
            
      }
        let heartAction = UIContextualAction(style: .normal, title: nil) { (action, view, completion) in
        // Perform your action here
          completion(true)
      }
        
        heartAction.image = UIImage(named: "heart")
        heartAction.backgroundColor = UIColor.systemGray6
        
    
        
        deleteAction.image = UIImage(named: "trash")
    
        deleteAction.backgroundColor = UIColor.systemGray6
        
      
      return UISwipeActionsConfiguration(actions: [deleteAction,heartAction])
    }
    
}
