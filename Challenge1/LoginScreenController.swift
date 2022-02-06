//
//  LoginScreenController.swift
//  Challenge1
//
//  Created by Anwesh M on 30/01/22.
//

import UIKit

class LoginScreenViewController: UIViewController{
    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var scrollViewContentViewHC: NSLayoutConstraint!
    
    var users: Set<User>? = UserDefaultsManager.getAllUsersDataFromPlist()

    
    override func viewDidLoad() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        self.view.addGestureRecognizer(tapRecognizer)
        eyeButton.setTitle("", for: .normal)
        
        
        let d = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        
        print(d)
        
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollViewContentViewHC.constant = UIScreen.main.bounds.size.height > UIScreen.main.bounds.size.width ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
    }
    
    override func viewWillAppear(_ animated: Bool) {
        users = UserDefaultsManager.getAllUsersDataFromPlist()
    }
    
    @IBAction func onLoginButtonClick(_ sender: Any) {
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard email.count > 0 else{
            Utils.showAlert(message: "Please enter Email Id.", view: self) { action in
            }
            return
        }
        
        guard password.count > 0 else{
            Utils.showAlert(message: "Please enter the password.", view: self) { action in
            }
            return
        }
        
        let user = users?.filter({ $0.email == email }).first
        let user2 = User(name: "", email: email, password: password, phoneNumber: "", address: "", gender: .other, location: nil)
        guard user == user2 else{
            print(user2)
            Utils.showAlert(message: "Please enter correct email/password", view: self) { action in
            }
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeScreenVC = storyboard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        homeScreenVC.user = user
        self.navigationController?.pushViewController(homeScreenVC, animated: true)
    }
    
    @IBAction func onSignUpButtonClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @IBAction func eyeButtonAction(_ sender: Any) {
        eyeButton.setImage(UIImage(systemName:   passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"), for: .normal)
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func onViewTapped(){
        self.view.endEditing(true)
    }
}
