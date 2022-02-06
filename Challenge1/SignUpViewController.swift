//
//  SignUpViewController.swift
//  Challenge1
//
//  Created by Anwesh M on 30/01/22.
//

import UIKit
import CoreLocation

class SignUpViewController: UITableViewController {
    
    
    // MARK  :-  References to UI Elements
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var genderTextField: UILabel!
    
    let locationManager = CLLocationManager()
    var currentLocation: UserLocation?
    
    var users: Set<User> = Set()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = UserDefaultsManager.getAllUsersDataFromPlist() ?? []
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onViewTapped))
        self.view.addGestureRecognizer(tapRecognizer)
        let tapRecognizerForGenderText = UITapGestureRecognizer(target: self, action: #selector(onGenderLabelTapped))
        self.genderTextField.addGestureRecognizer(tapRecognizerForGenderText)
        self.genderTextField.isUserInteractionEnabled = true
        genderTextField.text = genderEnum.other.rawValue
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupLocationPermissions()
    }
    
    @IBAction func onRegisterButtonClick(_ sender: Any) {
        pickerView.isHidden = true
        let (status, message) = validateUserData()
        guard status else{
            Utils.showAlert(title: "Error", message: message, view: self)
            return
        }
        locationManager.requestLocation()
        saveUserData()
    }
    
    @objc func onViewTapped(){
        self.view.endEditing(true)
        pickerView.isHidden = true
    }
    
    @objc func onGenderLabelTapped(){
        pickerView.isHidden = false
    }
    
    
    /// Validates the user entered data
    /// - Returns: returns tuple with status and error message
    private func validateUserData() -> (Bool, String){
        
        guard nameTextField.text!.trimmingCharacters(in: .whitespaces).count > 0 else{
            return (false, "Please enter your Name.")
        }
        
        guard emailTextField.text!.trimmingCharacters(in: .whitespaces).count > 0 else{
            return (false, "Please enter your Email.")
        }
        
        guard emailTextField.text!.isValidEmail else{
            return (false, "Please enter vaild Email Address.")
        }
        
        guard passwordTextField.text!.trimmingCharacters(in: .whitespaces).count > 0 else{
            return (false, "Please enter your Password.")
        }
        
        guard phoneNumberTextField.text!.trimmingCharacters(in: .whitespaces).count > 0 else{
            return (false, "Please enter your Phone number.")
        }
        
        guard addressTextField.text!.trimmingCharacters(in: .whitespaces).count > 0 else{
            return (false, "Please enter your Address.")
        }
        
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userExist = users.filter({ $0.email == email }).count > 0
        guard !userExist else{
            return (false, "An account with this email id already exist")
        }
        
        return (true, "")
        
    }
    
    private func saveUserData(){
        
        let name: String = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email: String = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password: String = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNumber: String = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let address: String = addressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let gender: genderEnum = genderEnum.allCases.filter { gender in
            gender.rawValue == genderTextField.text
        }.first!
        currentLocation =  UserLocation(latitude:  locationManager.location!.coordinate.latitude, longitude:  locationManager.location!.coordinate.longitude)
        let user = User(name: name, email: email, password: password, phoneNumber: phoneNumber, address: address, gender: gender, location: currentLocation)
        users.insert(user)
    
        UserDefaultsManager.saveUserDataToPlist(users: users)
        
        Utils.showAlert(message: "Registration success", view: self){_ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension SignUpViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderEnum.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genderEnum.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genderEnum.allCases[row].rawValue
        pickerView.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Helvetica Neue", size: 14)
        label.text =  genderEnum.allCases[row].rawValue
        label.textAlignment = .center
        return label
    }
    
}


extension SignUpViewController: CLLocationManagerDelegate{
    
    private func setupLocationPermissions(){
        locationManager.delegate = self
        
        guard CLLocationManager.locationServicesEnabled() else{
            Utils.showAlert(message: "Please Turn Location", view: self)
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
        let status = CLLocationManager.authorizationStatus()
        // Handle each case of location permissions
        switch status {
        case .authorizedAlways:
            locationManager.requestLocation()
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        case .denied, .notDetermined, .restricted:
            Utils.showAlert(message: "Please grant location permisions", view: self)
        @unknown default:
            Utils.showAlert(message: "Please grant location permisions", view: self)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Utils.showAlert(message: String(describing: error), view: self)
    }
}

