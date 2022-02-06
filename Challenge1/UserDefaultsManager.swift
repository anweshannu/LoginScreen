//
//  UserDefaultsManager.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import Foundation

class UserDefaultsManager{
    
    static func getAllUsersDataFromPlist() -> Set<User>?{
        if let data = UserDefaults.standard.value(forKey:"Users") as? Data {
            
            if let users = try? PropertyListDecoder().decode(Set<User>.self, from: data){
                print(String(describing: users))
                return users
            }
        }
        return nil
    }
    
    static func saveUserDataToPlist(users: Set<User>){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(users), forKey:"Users")
    }
}
