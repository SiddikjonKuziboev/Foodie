//
//  SeeMoreVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/6/21.
//

import UIKit
import SDWebImage
import RealmSwift
class SeeMoreVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom:10, right: 10)
        }
    }
    
    var data : [IteamDM]?
    var de: [IteamDM] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Foods"
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItems = [rightButton]
        de = MyFirstRealm.shared.fetchData()

    }
    @objc func addTapped(){
        navigationController?.popViewController(animated: true)
        
    }

}
extension SeeMoreVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        if let a = data {
            cell.imageView.sd_setImage(with: URL(string: base+a[indexPath.row].photo[0].url!), placeholderImage: #imageLiteral(resourceName: "image1"))
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-30)/2, height: 321)
    }
    
}
