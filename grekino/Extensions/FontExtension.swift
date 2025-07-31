//
//  FontExtension.swift
//  grekino
//
//  Created by Zach Freeman on 7/16/25.
//
import Foundation
import SwiftUI

extension Font {
    enum FontSize: CGFloat {
        case small = 14
        case medium = 18
        case large = 20
        case extralarge = 24
        case jumbo = 50
    }
    
    enum FontType: String {
        case bold = "Ubuntu-Bold"
        case regular = "Ubuntu-Regular"
        case bolditalic = "Ubuntu-BoldItalic"
        case italic = "Ubuntu-Italic"
        case light = "Ubuntu-Light"
        case lightitalic = "Ubuntu-LightItalic"
        case medium = "Ubuntu-Medium"
        case mediumitalic = "Ubuntu-MediumItalic"
    }
    
    /// Font Ubuntu
    ///
    /// - Parameter type: Font type you need
    /// - Parameter size: Font size you need
    /// - Returns: your custom font for custom size
    static func ubuntu(type: FontType, size: FontSize) -> Font {
        return .custom(type.rawValue, size: size.rawValue)
    }
    
    /// Font UbuntuSmall
    ///
    /// - Parameter type: Font type you need
    /// - Returns: your custom font for small size
    static func ubuntuSmall(type: FontType) -> Font {
        return ubuntu(type: type, size: FontSize.small)
    }
    
    /// Font UbuntuMedium
    ///
    /// - Parameter type: Font type you need
    /// - Returns: your custom font for medium size
    static func ubuntuMedium(type: FontType) -> Font {
        return .custom(type.rawValue, size: FontSize.medium.rawValue)
    }
    
    /// Font UbuntuLarge
    ///
    /// - Parameter type: Font type you need
    /// - Returns: your custom font for large size
    static func ubuntuLarge(type: FontType) -> Font {
        return .custom(type.rawValue, size: FontSize.large.rawValue)
    }
    
    /// Font UbuntuExtraLarge
    ///
    /// - Parameter type: Font type you need
    /// - Returns: your custom font for extra large size
    static func ubuntuExtraLarge(type: FontType) -> Font {
        return .custom(type.rawValue, size: FontSize.extralarge.rawValue)
    }
    
    /// Font UbuntuJumbo
    ///
    /// - Parameter type: Font type you need
    /// - Returns: your custom font for jumbo size
    static func ubuntuJumbo(type: FontType) -> Font {
        return .custom(type.rawValue, size: FontSize.jumbo.rawValue)
    }
    
}
