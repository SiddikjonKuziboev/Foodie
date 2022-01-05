//
//  BranchesMapVC.swift
//  Foodie
//
//  Created by Kuziboev Siddikjon on 7/6/21.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import SwiftyJSON
import SDWebImage
struct LocationDM {
    var _id : String
    var long: Double
    var lat :Double
    var name: String
    var photo: [String]
}
class BranchesMapVC: UIViewController {
    
    let cor = CLLocationCoordinate2D(
        latitude: 40.728,
        longitude: -74)
    
    
    var datas : [LocationDM] = []
    var pins: [MKPointAnnotation] = []
    
    
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        getLocation()
       
        
    }
    func getLocation() {
        AF.request(base+"/api/gio",headers: ["Authorization":Cache.getUserToken()]).responseJSON { response in
            if let data = response.data {
                
                let json = JSON(data)
                if json["success"].boolValue {
                    print("success")
                    
                    
                    let a = json["data"]
                    for i in a.arrayValue.enumerated() {
                        var photos = [String]()
                        
                        for j in i.element["photo"].arrayValue {
                            photos.append(j.stringValue)
                            
                        }
                       
                        let d = LocationDM(_id: a[i.offset]["_id"].stringValue,long: a[i.offset]["long"].doubleValue , lat: a[i.offset]["lat"].doubleValue, name: a[i.offset]["name"].stringValue, photo: photos)
                        self.datas.append(d)
                        print(self.datas,"1234")
                      
                    }
                    for i in self.datas {
                        let pin = MKPointAnnotation()
                        pin.coordinate = CLLocationCoordinate2D(latitude: i.lat, longitude: i.long)
                        pin.title = i.name
                        self.pins.append(pin)
                        self.map.addAnnotation(pin )
                       
                    }
                    
                }
                
            }
            
            
            
        }
    }


    @IBAction func gpsButton(_ sender: Any) {
        
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}

extension BranchesMapVC: MKMapViewDelegate {
    
}
