//
//  DoubleExtension.swift
//  grekino
//
//  Created by Zach Freeman on 7/23/25.
//
import Foundation

extension Double {
        
    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }
        
}
