//
//  Utils.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import Foundation
import UIKit


 class Utils{
    
     static func showAlert(title: String? = nil, message: String, view: UIViewController,  completionHandler: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "OK", style: .default, handler: completionHandler)
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
     
     static func showUserSettings() {
         guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else {
             return
         }
         UIApplication.shared.open(urlGeneral)
     }
     
     static func openLocationSettings(){
         /// To make this work you need to add URL schemes as prefs
         let url = URL(string: "App-prefs:root=LOCATION_SERVICES")
         UIApplication.shared.open(url!)
     }
    
}
