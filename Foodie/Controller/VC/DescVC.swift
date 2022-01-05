//
//  descVC.swift
//  FoodieApp
//
//  Created by Kuziboev Siddikjon on 05/07/21.
//

import UIKit

import SDWebImage
import Lottie
class DescVC: UIViewController {
    
    @IBOutlet weak var addCardBtnHeight: NSLayoutConstraint!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescripiton: UILabel!
    @IBOutlet weak var pageContr: UIPageControl!
    @IBOutlet weak var addCarBtn: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!{
        didSet{
            myCollectionView.delegate = self
            myCollectionView.dataSource = self
            myCollectionView.register(CVC.nib(), forCellWithReuseIdentifier: CVC.id)
            myCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        }
    }
    
   // var a: [UIColor] = [.red,.black,.green,.systemPink]
    var iteam: IteamDM?
    var cat_name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isSmallScreen {
            addCardBtnHeight.constant = 45
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addCarBtn.layer.cornerRadius = 30
        addCarBtn.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let it = iteam {
            lblCost.text = "\(it.cost))"
            lblName.text  = it.name
            lblDescripiton.text = it.discriptionn
            pageContr.numberOfPages = (it.photo.count)
            if let cName = cat_name {
                it.catName = cName
            }
        }
        
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        
        if let itea = iteam {
            MyFirstRealm.shared.saveIteam(iteam: itea)
             print("savedDesc")
        }
    }
}
//MARK: Collection View Delegates
extension DescVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iteam?.photo.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "CVC", for: indexPath) as! CVC
        guard let d = iteam else {
            return UICollectionViewCell()
        }
        
        cell.imageV.sd_setImage(with: URL(string: base + d.photo[indexPath.row].url!), placeholderImage: #imageLiteral(resourceName: "ProfileVCFemale"))
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (view.frame.width-40), height: 200)
        return cellSize
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        pageContr?.currentPage = Int(round((scrollView.contentOffset.x) / scrollView.frame.width))
    }


}
