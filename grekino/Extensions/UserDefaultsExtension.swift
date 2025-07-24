//
//  UserDefaultsExtension.swift
//  grekino
//
//  Created by Zach Freeman on 7/24/25.
//
import Foundation

enum UserDefaultsKeys: String {
    case userId
}

extension UserDefaults {
    func setUserId(value: String) {
        set(value, forKey: UserDefaultsKeys.userId.rawValue)
    }
    
    func getUserId() -> String? {
        return string(forKey: UserDefaultsKeys.userId.rawValue)
    }
}
