//
//  Tabs.swift
//  grekino
//
//  Created by Zach Freeman on 7/9/25.
//
import SwiftUI

enum Tabs: Equatable, Hashable, Identifiable {
    case one
    case two
    case three
    case four
    case search
    
    var id: Int {
        switch self {
        case .one: 1
        case .two: 2
        case .three: 3
        case .four: 4
        case .search: 5
        }
    }
    
    var name: String {
        switch self {
        case .one: "One"
        case .two: "Two"
        case .three: "Three"
        case .four: "Four"
        case .search: "Search"
        }
    }
    
    var symbol: String {
        switch self {
        case .one: "1.circle"
        case .two: "2.circle"
        case .three: "3.circle"
        case .four: "4.circle"
        case .search: "magnifyingglass"
        }
    }
}
