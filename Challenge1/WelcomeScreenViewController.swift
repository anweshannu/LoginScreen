//
//  ViewController.swift
//  Challenge1
//
//  Created by Anwesh M on 30/01/22.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet weak var welcomeText: UILabel!
    @IBOutlet weak var scrollViewContentViewHC: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        scrollViewContentViewHC.constant = UIScreen.main.bounds.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollViewContentViewHC.constant = UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
    }
    
    @IBAction func onLoginBtnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginScreenViewController")
        self.navigationController?.pushViewController(loginVC, animated: true)
        
    }
    
    @IBAction func onSignUpBtnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        signUpVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}

