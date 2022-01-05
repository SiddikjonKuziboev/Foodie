



import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var sheepImg: UIView!
    @IBOutlet weak var sheepConstr: NSLayoutConstraint!
    @IBOutlet weak var fooodLbl: UILabel!
  
    @IBOutlet weak var conView: UIView!
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var getConstr: NSLayoutConstraint!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        if isSmallScreen {
            fooodLbl.font = UIFont.systemFont(ofSize: 40)
            
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getStartedBtn.layer.cornerRadius = getStartedBtn.frame.height/2
        
    }

    @IBAction func getStartedPressed(_ sender: Any) {
        let vc = LoginVC(nibName: "LoginVC", bundle: nil)
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
    

}
