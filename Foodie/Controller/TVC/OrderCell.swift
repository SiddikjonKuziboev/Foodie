//
//  OrderCell.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/25/21.
//

import UIKit

class OrderCell: UITableViewCell {
    
    
    @IBOutlet weak var tab2View: UITableView! {
        didSet {
            tab2View.dataSource = self
            tab2View.delegate = self
            tab2View.register(OrderCell2.nib(), forCellReuseIdentifier: OrderCell2.identifair)
        }
    }
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var conView: UIView!
  
    
    
    
    
    
    
    
    
    static let identifair = "OrderCell"
    static func nib()->UINib {
    return UINib(nibName: "OrderCell", bundle: nil)
    }
    var data : OrderDM?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conView.layer.cornerRadius = 10
        conView.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        conView.layer.shadowOffset = CGSize(width: 4, height: 4)
        conView.layer.shadowRadius = 5
        conView.layer.shadowOpacity = 0.6
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(data: OrderDM, index: IndexPath) {
        self.data = data
        lblTime.text = "\(String(describing: data.createdAt))"

        statusView.layer.borderWidth = 2
        statusView.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        if data.status == "Pending" {
            statusView.backgroundColor = .yellow
            
        }else {
            statusView.backgroundColor = .red
        }
        
        
        
    }
    
}
extension OrderCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = self.data {
        return data.products.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tab2View.dequeueReusableCell(withIdentifier:                         OrderCell2.identifair, for: indexPath)as! OrderCell2
      
        if let data = self.data {
            cell.selectionStyle = .none
            cell.lblCategory.text = data.products[indexPath.row].category
            cell.lblSum.text = "\(data.products[indexPath.row].sum)"
            cell.lblQuantity.text = "\(data.products[indexPath.row].quantity)"
        }
        return cell
    }
    
    
}
