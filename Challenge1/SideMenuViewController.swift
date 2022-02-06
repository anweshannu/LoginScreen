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
    
    var users: Set<User> = Set()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.isUserInteractionEnabled = true
        self.usernameTextLabel.isUserInteractionEnabled = true
        usernameTextLabel.text = "Hi Anwesh!"
        
        if let users = UserDefaultsManager.getAllUsersDataFromPlist(){
            self.users = users
        }
        usernameTextLabel.text = "Hi \(users.first!.name)!"
        
    }
    

    @IBAction func onLogOutButtonTapped(_ sender: Any) {
        print("Working...")
       
        self.dismiss(animated: true){
            
            self.homeDelegate.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
