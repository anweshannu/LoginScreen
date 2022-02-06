//
//  UserDataModel.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import Foundation
import CoreLocation

struct User:  Codable, Hashable, Equatable{
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let address: String
    let gender: genderEnum
    let location: UserLocation?
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email && lhs.password == rhs.password
    }
    
}

struct UserLocation: Hashable, Codable{
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

enum genderEnum: String, Codable, CaseIterable{
    case male = "Male"
    case female = "Female"
    case other = "Other"
}
