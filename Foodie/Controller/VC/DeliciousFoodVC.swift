//
//  DeliciousFoodVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/4/21.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import RealmSwift
import Lottie

class FoodDM {
    var isRed: Bool
    init( isRed: Bool) {
        self.isRed = isRed
    }
}

class DeliciousFoodVC: UIViewController, IsPressedDelegate {
    func pressed(bool: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity
            self.view.backgroundColor = .white
            self.containerView.layer.cornerRadius = 0
            self.navigationController?.navigationBar.isHidden = false
            
        } completion: { _ in
            self.tabBarController?.tabBar.isHidden = false

        }
    }
    
    @IBOutlet weak var littleCollHeight: NSLayoutConstraint!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var bigCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lotView: UIView!
    @IBOutlet weak var containerView: UIView!
    var animatioView: AnimationView!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        }
}
    
    
    @IBOutlet weak var foodsCollection: UICollectionView!{
        didSet {
            foodsCollection.delegate = self
            foodsCollection.dataSource = self
            foodsCollection.register(UINib(nibName: "FoodsCell", bundle: nil), forCellWithReuseIdentifier: "FoodsCell")
        }
    }
    
    var datas : [IteamDM] = []
    var imgs : [UIImage] = []
    var fName: [String] = []
    
    var foodname:[FoodDM] = [
        FoodDM(isRed: true),
        FoodDM(isRed: false),
        FoodDM(isRed: false),
        FoodDM(isRed: false)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigation()
        navigationController?.navigationBar.shouldRemoveShadow(true)
        initPin()
        animatioView.play()
        
        if isSmallScreen {
            bigCollViewHeight.constant = 150
            littleCollHeight.constant = 36
            lblHeight.font = UIFont.systemFont(ofSize: 27)
            
            
            
            
        }else{
          //  bigCollViewHeight.constant = 240
        }
    
    }
        
    override func viewWillAppear(_ animated: Bool) {
        datas = []
        fName = []
        getCatalogName()
        getData(type: "foods")
        foodsCollection.reloadData()
        collectionView.reloadData()
        
       navigation()
         
         
    }
//    MARK: Animation
    fileprivate func initPin() {
        
        animatioView = AnimationView(name: "8774-loading")
        animatioView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        lotView.addSubview(animatioView)
        animatioView.loopMode = .loop
        
    }
    func navigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .done, target: self, action: #selector(self.leftBtn))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .done, target: self, action: #selector(self.rightBtn))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .systemGray

        
    }
    func getCatalogName() {
        
        AF.request( base+"/api/categories",headers: ["Authorization":Cache.getUserToken()]).responseJSON { response in
            
            if let data = response.data {
                let json = JSON(data)
              
                for i in json["data"].arrayValue {
                    self.fName.append(i["name"].stringValue)
                    
                }
                self.foodsCollection.reloadData()
            }
        }
    }
    
    func getData(type: String) {
        
        AF.request(base+"/api/\(type)", method: .get,headers: ["Authorization":Cache.getUserToken()]).responseJSON { response in
            
           
                if let data = response.data {
                    
                    let d = JSON(data)
                    if d["success"].boolValue {
                        self.animatioView.stop()
                        self.lotView.isHidden = true
                        self.datas.removeAll()
                        
                    for i in 0..<d["data"].count {
                        let photo : List<PhotoDM> = List<PhotoDM>()
                        
                    for i in d["data"][i]["photo"].arrayValue {
                        let a = PhotoDM()
                        a.url = i.stringValue
                            photo.append(a)
                        }

                        let it = IteamDM()
                        it._id = d["data"][i]["_id"].stringValue
                        it.cost = d["data"][i]["cost"].intValue
                        it.discriptionn = d["data"][i]["discription"].stringValue
                        it.name = d["data"][i]["name"].stringValue
                        it.photo = photo
                        self.datas.append(it)
                        self.collectionView.reloadData()
                    }
                }
           }
        }
    }
    
    
    //MARK: LeftBtn
    @objc func leftBtn(){

        let vc = MenuVC(nibName: "MenuVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        UIView.animate(withDuration: 0.5) {
            self.containerView.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0).scaledBy(x: 0.7, y: 0.7)
            
            self.containerView.layer.cornerRadius = 30
            self.view.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
            self.containerView.layer.shadowColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
            self.containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
            self.containerView.layer.shadowRadius = 10
            self.containerView.layer.shadowOpacity = 0.9
            
            
            
        } completion: { _ in
        
        }
        
        
        present(vc, animated: false, completion: nil)
        
    }
    
    @objc func rightBtn(){
        let vc = CartVC(nibName: "CartVC", bundle: nil)
    
       
        navigationController?.pushViewController(vc, animated: true)
    }
   
    
    @IBAction func btnNavigation(_ sender: Any) {
        
        let vc = SeeMoreVC(nibName: "SeeMoreVC", bundle: nil)
        vc.data = datas
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


//MARK: CollectionViewDelegates
extension DeliciousFoodVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionView{
            return datas.count
            
        }else{
            
            return fName.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.foodsCollection{
            let cell = foodsCollection.dequeueReusableCell(withReuseIdentifier: "FoodsCell", for: indexPath) as! FoodsCell
            
            if foodname[indexPath.row].isRed {
                UIView.animate(withDuration: 0.5) {
                    cell.labelFoods.textColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
                    cell.viewCell.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.2901960784, blue: 0.04705882353, alpha: 1)
                }
                
            }else {
                cell.viewCell.backgroundColor = .clear
                cell.labelFoods.textColor = .gray
            }
            
            cell.labelFoods.text = fName[indexPath.row]
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            
            cell.animationView.play()
            cell.animateView.isHidden = false
            
            
            cell.lblCost.text = "\(datas[indexPath.row].cost)"
            cell.lblName.text = datas[indexPath.row].name
            cell.screenSize()
            cell.containerView.layer.cornerRadius = 30
            if !datas[indexPath.row].photo.isEmpty{
                
                cell.imageView.sd_setImage(with: URL(string: base+datas[indexPath.row].photo[0].url!), placeholderImage: #imageLiteral(resourceName: "circleGray"))
                cell.animationView.stop()
                cell.animateView.isHidden = true
            }
       
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.foodsCollection{
            
            if isSmallScreen {
                return CGSize(width: 60, height: 46)
            }else {
                return CGSize(width: 100, height: 56)
            }
            
            
        }else{

            if !isSmallScreen {
                return CGSize(width: 150 , height: 230)
            }else {
                return CGSize(width: 220 , height: 300)
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView == self.foodsCollection{

            return UIEdgeInsets(top: 0, left: 75, bottom: 0, right: 75)
        }else{
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
            }
        }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.foodsCollection {
            for i in foodname {
                i.isRed = false
            }
            foodname[indexPath.row].isRed = true
            foodsCollection.reloadData()
                    
            if fName[indexPath.row] == "drinks" {
                getData(type: "drinks")
            }
            
            if fName[indexPath.row] == "snacks" {
                getData(type: "snacks")
            }
            
            if fName[indexPath.row] == "souces" {
                getData(type: "souces")
            }
            
            if fName[indexPath.row] == "foods" {
                getData(type: "foods")
            }
            
            collectionView.reloadData()
          
            }else {
                
                let vc = DescVC(nibName: "DescVC", bundle: nil)
                
                for i in foodname.enumerated() where i.element.isRed {
                    vc.cat_name = fName[i.offset]
                }
                vc.iteam = datas[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                
                }
        }
}

