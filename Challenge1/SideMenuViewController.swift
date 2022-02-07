//
//  SideMenuNavigationController.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {

    @IBOutlet weak var usernameTextLabel: UILabel!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var logOutButtonTapped: UIButton!
    
    weak var homeDelegate: HomeScreenViewController!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        self.usernameTextLabel.isUserInteractionEnabled = true
        usernameTextLabel.text = "Hola!!"
        usernameTextLabel.text = "Hi \(user.name)!"
        
    }
    

    @IBAction func onLogOutButtonTapped(_ sender: Any) {

        self.dismiss(animated: true){
            self.homeDelegate.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
